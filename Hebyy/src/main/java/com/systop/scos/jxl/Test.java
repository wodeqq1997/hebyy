package com.systop.scos.jxl;

// 生成Excel的类 
import java.io.File;

import jxl.Sheet;
import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

public class Test {
	public static void main(String args[]) {
		try {
			// 打开文件
			WritableWorkbook book = Workbook.createWorkbook(new File(
					" test.xls "));
			// 生成名为“第一页”的工作表，参数0表示这是第一页
			WritableSheet sheet = book.createSheet(" 第一页 ", 0);
			// 在Label对象的构造子中指名单元格位置是第一列第一行(0,0)
			// 以及单元格内容为test
			for (int i = 0; i < 10; i++) {

				for (int j = 0; j < 10;) {
					Label label = new Label(j, i, "" + i);

					// 将定义好的单元格添加到工作表中
					sheet.addCell(label);

					Label label2 = new Label(j + 1, i, i + "aaaa");
					sheet.addCell(label2);
					break;
				}
			}
			/**//*
				 * 生成一个保存数字的单元格 必须使用Number的完整包路径，否则有语法歧义 单元格位置是第二列，第一行，值为789.123
				 */
			// jxl.write.Number number = new jxl.write.Number(1, 0, 555.12541);
			// sheet.addCell(number);

			// 写入数据并关闭文件
			book.write();
			book.close();
			getXls();

		} catch (Exception e) {
			System.out.println(e);
		}
	}

	public static void getXls() {
		try {
			Workbook book = Workbook.getWorkbook(new File("新龙集团2013年3月通讯录.xls"));
			// 获得第一个工作表对象
			Sheet[] sheets = book.getSheets();
			System.out.println(sheets.length);
			for(Sheet sheet : sheets){
				int columnsNum = sheet.getColumns();
				int rowsNum = sheet.getRows();
				System.out.println(columnsNum);
				System.out.println(rowsNum);
				System.out.println("-----------");
			}
			// 得到第一列第一行的单元格
//			int columns = sheet.getColumns();
//			int rows = sheet.getRows();
//			for (int i = 0; i < columns; i++) {
//				for (int j = 0; j < rows; j++) {
//					if (i + 1 < columns) {
//						Cell cell1 = sheet.getCell(i, j);
//						String result = cell1.getContents();
//						Cell cell2 = sheet.getCell(i + 1, j);
//						String result2 = cell2.getContents();
//						System.out.print(result + "---------" + result2);
//						System.out.println();
//					}
//				}
//			}
			book.close();
		} catch (Exception e) {
			System.out.println(e);

		}
	}
}
