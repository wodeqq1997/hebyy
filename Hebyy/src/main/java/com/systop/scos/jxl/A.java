package com.systop.scos.jxl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import jxl.Image;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

/** * @author Qin_Tianxiang * jxl读取.xls文件(可读取所有的sheet) */
public class A {
	private String filetype = null;
	private Workbook wb = null;

	public A(String filepath) throws Exception {
		if (filepath.trim().equals("") || filepath == null) {
			throw new IOException("参数不能为空或全为空格!");
		}
		this.filetype = filepath.substring(filepath.lastIndexOf(".") + 1);
		InputStream is = new FileInputStream(filepath);
		if (filetype.equalsIgnoreCase("xls")) {
			System.out.println("xls格式文件");
			wb = Workbook.getWorkbook(is);// 创建工作薄
		} else {
			throw new Exception("不是.xls文件，请选择.xls格式文件!");
		}
	}

	public void RaadXls() throws Exception {
		Sheet[] sheets = wb.getSheets();// 获取所有的sheet
		for (int x = 0; x < sheets.length; x++) {
			Sheet s = wb.getSheet(x);// 获取sheet //
										// System.out.println(s.getRows()+"sheet的行数");
			if (s.getRows() == 0) {// 判断sheet是否为空 System.out.println("Sheet" +
									// (x + 1) + "为空!");
				continue;
			} else {
				// 通用的获取cell值的方式,getCell(int column, int row) 行和列
				int Rows = s.getRows();// 总行
				int Cols = s.getColumns();// 总列
				System.out.println("当前工作表的名字:" + s.getName());
				System.out.println("总行数:" + Rows);
				System.out.println("总列数:" + Cols);
				String[][] str = new String[Rows][Cols];
				for (int i = 0; i < Rows; i++) {
					for (int j = 0; j < Cols; j++) {
						str[i][j] = (s.getCell(j, i)).getContents();// getCell(Col,Row)获得单元格的值
						System.out.print(str[i][j] + "\t");
					}
					System.out.print("\n");
				}
			}
		}
		wb.close();
		// 操作完成时，关闭对象，释放内存
	}

	private Map<Integer, byte[]> map = new HashMap<Integer, byte[]>();

	public Map<Integer, byte[]> readPictureData(String excelPath)
			throws BiffException, IOException {
		// Excel工作薄對象
		Workbook book = Workbook.getWorkbook(new File(excelPath));
		// 第一張工作表對象
		Sheet sheet = book.getSheet(0);
		for (int i = 0; i < sheet.getNumberOfImages(); i++) {
			Image image = sheet.getDrawing(i);
			if (image != null) {
				// System.out.println("image.getRow()--->" + image.getRow());
				int key = (int) image.getRow();// 拿到圖片所在的行索引
				// System.out.println("key--->" + key);
				byte[] imageData = image.getImageData();// 拿到該行圖片的字節數據
				map.put(key, imageData);
			} else {
				break;
			}
		}
		return map;
	}

	@SuppressWarnings("rawtypes")
	public static void getMap(Map<Integer, byte[]> map) {
		Set entries = map.entrySet();
		if (entries != null) {
			Iterator iterator = entries.iterator();
			while (iterator.hasNext()) {
				Map.Entry entry = (Entry) iterator.next();
				Object key = entry.getKey();
				Object value = entry.getValue();
				System.out.println(key);
				System.out.println(new String((byte [])value));
				
			}
		}
	}

	public static void main(String[] args) throws Exception {
		new A("E://副本新龙集团2013年3月通讯录.xls").RaadXls();
		Map<Integer, byte[]> map = new A("E://副本新龙集团2013年3月通讯录.xls")
				.readPictureData("E://副本新龙集团2013年3月通讯录.xls");
		getMap(map);
	}

}
