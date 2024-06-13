Return-Path: <linux-kernel+bounces-212689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDB39064EE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2611F24500
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 07:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A58757E5;
	Thu, 13 Jun 2024 07:24:43 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79CD5914A;
	Thu, 13 Jun 2024 07:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263483; cv=fail; b=dF6tgesGiUaWVECZUMtP7iE+IACLjGH52JumfUUYPooSnSSeJkSPo/P+sgImDe54IkK+9Q0lhq69sMZDC7M/xCWua48vFHyzCza/qDGUEJ6mf6UyNaWZzpKCVnPlrMLmde59Fl2ig2/DWVa7LTeQ+u+xeDYA5pEeumTMEfB6gCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263483; c=relaxed/simple;
	bh=4OtXYAVA7ZUK6d2AF2X0zh9Njme12b81nbPklF1Ch5I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ob7a6M4iVT3JmAEz9gshgG576IgN72jKGl2fzwxjE0oZ36e5x1UAZgUutetj2gHnMMp9GFu7d0Y4ySubYnqZOG3dAwD0idJOoymeQNtlM4dEgiv6as1bjQMezxtjxgh/bNnaBMMmEDyAwQsxhdV9pD1sDSmm2hGjXbcnbw1U7/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D5U2ah030655;
	Thu, 13 Jun 2024 00:23:30 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ymptg4myu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 00:23:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g40URpQBrqXabDEoY2VRK7yaqBmwWW+fZMrBXxpKrQcq+mXBcD7Cv0wrh3qOwLfvFg5KE08hTeFfwJHoAWZ/J1FXrF4KdXVuPIxrTnFwGwF5WpNfVm+e/X5u/olpwsoPYyp5fac59zJU1lqLHGrKiLC2uLizABN1roJZeQhMmy3Vjc/d34v/b3tkEg5SlybBS75lxxiekK9OnShdY8xJd5WM+kO16q/EJEP/OmLfLQK4rON9jVhn3zjxcxQMYbgsEgu7mQYMlTfMObxHqM2xuegWEUoLNRGLcQi7Q3Rfpqxdi9R+9qS4mm6gtYdooVxbivm9d9NYLvbZUkIm4jIEog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iNIUES0lFAoHJxKY6UtV0RodHnCYpOmFkEw883KvI4=;
 b=VHCWaypxZOIMg/WXH8Y8vYBlSRT2+oepWCrJZq3vQE2v2oV0gF/ZRrrTWU2HZ3/Lr0dKiMu71pQJYSAp6Sbjag4PqKVum6zp8Q8O1jFD7A98JSTYbAkK54u+1B/AS9OExx7E4Wkp049peuhxOMLmXr05hstQ2CXiJo95mO51cv9l93p5fZidtS3CLNGdXkrVdJwh1Jl+1BRozJIVLufoYFQ96qPbKtMP1Fur5rIM+VOoke2S0Uwg2ETMNglk0lEne/XaRmikV00ztsjDfa4oNbKhJ6YgFlTvD+BDnTXsCaUwIv2gxVooUni1+Jhj4WTys5VpaQeWwi+JB2W0bsZhjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by IA0PR11MB7354.namprd11.prod.outlook.com (2603:10b6:208:434::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 07:23:26 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e9d7:7193:8b2b:f0b9]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e9d7:7193:8b2b:f0b9%3]) with mapi id 15.20.7677.019; Thu, 13 Jun 2024
 07:23:26 +0000
From: Meng Li <Meng.Li@windriver.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
        quic_uaggarwa@quicinc.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: meng.li@windriver.com
Subject: [PATCH] usb: dwc3: core: remove lock of otg mode during gadget suspend/resume to avoid deadlock
Date: Thu, 13 Jun 2024 15:23:10 +0800
Message-Id: <20240613072310.1927966-1-Meng.Li@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0101.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::14) To PH0PR11MB5191.namprd11.prod.outlook.com
 (2603:10b6:510:3e::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5191:EE_|IA0PR11MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: e13b66ca-d5b3-4f82-3f5b-08dc8b79b711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230034|376008|1800799018|366010|52116008|38350700008;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?iJRM5lsdLPksYUzPv001SLgHP5ZvcHsSvX0ZcU92kispdeK/RVvEQvcPrT05?=
 =?us-ascii?Q?hqgIfqReJGaFWZfwZn8hDlxZYY4FW8eBgOi7FX7nm0PDZadvoVWzZTFZcImw?=
 =?us-ascii?Q?7hizOLRVGgZ9KtCls2/Xprw4O9C6ASa/J5u1c/LDEy4FXDSEC7hQGIP/npur?=
 =?us-ascii?Q?bA8gl0PDtV5JcJO9v5qnTqcbeSKeUmiIOK2TJKVqUKWJKQrGfwtzT8cUzGG3?=
 =?us-ascii?Q?Qd46QylsMTMOLkTKud3pPjAzCCd15lxz1aGAQ8kGLNnz3U5+vE6m1TXC2tz6?=
 =?us-ascii?Q?ntTcEkP/zv2g1BkdhjsWH3hejRv2YhmhT2UFkKWYYrleSAQll05u4I8p+696?=
 =?us-ascii?Q?L+ONxyOFJ80QRbHGmHjf0X7o8SnqGzsdWTw2xuD8jLwVq3uux5YmzVuSrDYa?=
 =?us-ascii?Q?zYWdKglAy1wATK6aiqmOz5YaMOF1O3sS+rrBm1GUTr2j425Xg6Lov0kEv/3Y?=
 =?us-ascii?Q?/MRT98YeE0jvmljjwQR90LOH3MrEqqPm3XGXsCNnoM4ihMI2BXPgUERlblzo?=
 =?us-ascii?Q?YHK4YNv/7qocvVDO4g0n2KpUX1/hhATUHVkECUVilIExuvT4BY4orpOXSlk/?=
 =?us-ascii?Q?IEk29hj9bt10GmA83BorCJrj/j1sNW1TObqPz9s6SNfp8SnsF+JtdFAVm+HG?=
 =?us-ascii?Q?DMXOMBZm/mhUYi5jU4nlKgzS+HyYv/jxI5q8WW7fDEa1/LI0PHZOqKIdyPJt?=
 =?us-ascii?Q?fipczlUWzzMpO8BPCELJrk8RzTLtCm1qXEsUnOVcUad3tccCO9sG10anOV+L?=
 =?us-ascii?Q?+7JMUE0lQdtk0r8ORp/K0RdbyISEPhQXeWEYEj6UtlxR2RJNUtclrt1NBA58?=
 =?us-ascii?Q?nD2kCv7e+PYZ/pdLlNw2rxNuT/hf3AqY2FcMQuUKB8VWNm/JBwL922kkGdBd?=
 =?us-ascii?Q?1pwi7ccGm9C7PYBDtpBzmetdWWhJG1bGH06T/T6sMf6OYN3QlwHalA4cEzeh?=
 =?us-ascii?Q?iktG8AZp5AkxSixyV+Yp+2Rsr2Irm6ZCQlm1b6wEmJNOHKxJs8zaMDFTu33o?=
 =?us-ascii?Q?EhlsqA33mlngaRLBGaD36eFl1EBoGOW92rZMZepvn8Og+LXCUggeLpWOCVU1?=
 =?us-ascii?Q?e0f71P7lUSfBYmEk/BYDpw979f7pY4stuoPlupe+AbvRy/lwTRM9r2ZN2u82?=
 =?us-ascii?Q?86yq5d8Ad7AdjQZydEFUERo0ptrXbaSuGxUkAlX+F9+/Ho5VzydVwvEgdD/a?=
 =?us-ascii?Q?t0DHnG97oxLReCl4ELeaeFLXfJnox6FXmReTHkRfz79xkoBwEVUDAtgBQA9M?=
 =?us-ascii?Q?Ud6mRmMIyExQXS545wTFFNEj0vyWSUfcoLfMh2Bk75HTvjbM2fK+yeAL1I2j?=
 =?us-ascii?Q?0vOsxOjU9/3xXk5kGxcbq3jUGnAzRnX7Fp02v0uZBkBlYE86t9nUzw+W0sxL?=
 =?us-ascii?Q?+iUztRw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(52116008)(38350700008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hL3SRnoloTOj9K4JATkInJKqID9kxpWXxbrtz4aPf7dZjT25a4Tkl6hq/3wJ?=
 =?us-ascii?Q?7ZPdbw0wo1RLmBe9hqA4+i+igMKKUiwzMi/gT5FfYQ1vWEum+GGBt4rcZtFH?=
 =?us-ascii?Q?jeLXbrGO9LZW8GZSel7iL0mOxb/efo4AcSRQWGNIZDHasKGyKGIViwb3tRHs?=
 =?us-ascii?Q?RCnOIhq2NpRZnuWvhK/v/xQx5GzAPHgquEdGg5kj9Si4mRoJVyqTp8ltJaVW?=
 =?us-ascii?Q?m3I2vG7/UiTi0v6tV72cXT93giQpNj4KI0jC8Qiqu5AKz/GJNGHgFI9NQuIY?=
 =?us-ascii?Q?T+uEhlMIrBFeOokFX1eiBI4F5hwqeypA8eY1xdyVN+FuYvoEclezPJ8GYh9D?=
 =?us-ascii?Q?772PICadfsxSiPqNnvHDmBdz7j+pbwhFAKX7un+h/XfpRoLU3UaPiSRP4JCp?=
 =?us-ascii?Q?46PVjrgxz+Klf/UwsIr0zXzeb06GEx1N0m1PsfNFadnEeIUdUxYtiO1V9oZe?=
 =?us-ascii?Q?ecBtKNr0+xlpB18reL2b7TE1jlPm00QYMtFzcJIYm1//WF65jn1x9Z5bnyIh?=
 =?us-ascii?Q?Eaffkd9NndG0AbO2YLxkAxz2JGVPbfxVL09R4CYI6jwOAlS0MZL33zv4r17G?=
 =?us-ascii?Q?ewBXFea/9J1oiEliEdlZrA4mHoz3qQlSQF6HoPvNzthSAGetbeztXlpErJOR?=
 =?us-ascii?Q?YTd8ZguR3k6kUYYxCUgrnJIxvHbZNb78gLpSXWOPe2SaZ7q7+WLaL/dhXhRF?=
 =?us-ascii?Q?/+VTJEG5nwWQXm6Yqcg/dOEnfHm04n3hBTYyhptzj9GEVqKMPcrD+Vsm+inz?=
 =?us-ascii?Q?NaTXKBrbcpgvQDvBZfM895KN1tycjR3Fb+/WZCtBAt8XogwFYrBU8YRBsjCi?=
 =?us-ascii?Q?BABBrZL39kNVMo+PXOLm0ATqkGrWv2xo2eDn85Yq31uQHoP0qAPkdWsi6jqt?=
 =?us-ascii?Q?G7eplF1Og9D9Q5M1iJgsJONU8LuMD2vj5krHEp86WP7hbZv1M5op4O3h8Rm5?=
 =?us-ascii?Q?DDtxD/PhRIh6jZwqf51Tr2fNPBOEujqi5zAiKpuJJxAtcu8goXcQZCRgbZY7?=
 =?us-ascii?Q?vKhWWLmiXOKavcxAAevy1/KrJrA4xqAkwyvH9BbYs3V+VIhCsSDjYGJgjJdA?=
 =?us-ascii?Q?69y7qda9Vipi471FDutZCpRqdHvSbKwtS2MO93XavHqbB7KeE1ca3hYV09Jr?=
 =?us-ascii?Q?7+Hw1REWs7J08vRkU+nLDAkyhlJxgjxmnW/cQnGeJwsyCFnxTZfEp+lAIejr?=
 =?us-ascii?Q?CL8soW0TCwbdaKg+yK9oLpkuPxZ2Gie1dGX/dxKFEkOt3ZaftNYoYPFrI+rq?=
 =?us-ascii?Q?b4FPNmy75m/I5o5lIUCmHj+CqUuA06H6wHpP8exTsm5s/t9rz7tmjwrQVT4H?=
 =?us-ascii?Q?YoYcx9ni1ncksF06vkw8FXz8EoFiMLFybWHAmLs8EHRnLTgltmaZ9S2sl1NX?=
 =?us-ascii?Q?Sq0eNRdANWR7+eVg8dI581db1tIGBMuhL00XAcX5hQ/iEc9EtZAsFfnTOlgI?=
 =?us-ascii?Q?vzqm8pMsRcrom2LnwggyoFlXlIy0xcXLxl6aTnApMG9CUZqtCRLAqkF2VS9d?=
 =?us-ascii?Q?3CjOz/J5AVTnDPHi7D49pagvqwhLCESQuWH59bT94GdMr52MBVori/VkqMdV?=
 =?us-ascii?Q?VQxgwvrsJNfBiJUmZLQ1ep5H1o3PZKLawK0hbuxJ?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e13b66ca-d5b3-4f82-3f5b-08dc8b79b711
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 07:23:26.0210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LeLWGqEwdLYD4kqqH80XbdrefRAnHP0hKtsb+cQTE3EY+Rv6eswAOFVbynjjDhWR1z/THlgyVu0IgRgRSMhgmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7354
X-Proofpoint-ORIG-GUID: Ddb3LZhHv-CKQVgClBeJCYYt1qEdmC1l
X-Proofpoint-GUID: Ddb3LZhHv-CKQVgClBeJCYYt1qEdmC1l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_12,2024-06-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.21.0-2405170001
 definitions=main-2406130051

When config CONFIG_USB_DWC3_DUAL_ROLE is selected, and trigger system
to enter suspend status with below command:
echo mem > /sys/power/state
There will be a deadlock issue occurring. Because dwc3_gadget_suspend() also
try to get the lock again when previous invoked dwc3_suspend_common() has
got the lock . This issue is introduced by commit c7ebd8149ee5 ("usb: dwc3:
gadget: Fix NULL pointer dereference in dwc3_gadget_suspend") that removes
the code of checking whether dwc->gadget_driver is NULL or not. It causes the
following code is executed and deadlock occurs when trying to get the spinlock.
To fix the deadlock issue, refer to commit 5265397f9442("usb: dwc3: Remove
DWC3 locking during gadget suspend/resume"), remove lock of otg mode during
gadget suspend/resume.

Fixes: c7ebd8149ee5 ("Fix NULL pointer dereference in dwc3_gadget_suspend")
Cc: stable@vger.kernel.org
Signed-off-by: Meng Li <Meng.Li@windriver.com>
---
 drivers/usb/dwc3/core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index a8fb10cc65bc..9bb4ab409bbb 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2112,7 +2112,6 @@ static int dwc3_core_init_for_resume(struct dwc3 *dwc)
 
 static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 {
-	unsigned long	flags;
 	u32 reg;
 
 	switch (dwc->current_dr_role) {
@@ -2150,9 +2149,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 			break;
 
 		if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
-			spin_lock_irqsave(&dwc->lock, flags);
 			dwc3_gadget_suspend(dwc);
-			spin_unlock_irqrestore(&dwc->lock, flags);
 			synchronize_irq(dwc->irq_gadget);
 		}
 
@@ -2169,7 +2166,6 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 
 static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 {
-	unsigned long	flags;
 	int		ret;
 	u32		reg;
 
@@ -2227,9 +2223,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		if (dwc->current_otg_role == DWC3_OTG_ROLE_HOST) {
 			dwc3_otg_host_init(dwc);
 		} else if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
-			spin_lock_irqsave(&dwc->lock, flags);
 			dwc3_gadget_resume(dwc);
-			spin_unlock_irqrestore(&dwc->lock, flags);
 		}
 
 		break;
-- 
2.34.1


