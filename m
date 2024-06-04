Return-Path: <linux-kernel+bounces-201093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727418FB940
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95F681C209F1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E34A1487F6;
	Tue,  4 Jun 2024 16:42:39 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98C41E501
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717519358; cv=fail; b=gL6evsi1aWGKdvQ/PL55K8I0oS+k8kQPtLj2JAstrx+2Y9mYbXhLoJhShHrCsZHRRdoVAyQsvjq13QJObufprbEa3COy/Igtmg8IkC3XLzUXqaQGhQcbSoZ3ezhIPzKHFN3Eu0O5X3rDVfsjzK7IyzLhzq5baLJTDtUxuByOa/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717519358; c=relaxed/simple;
	bh=jFqNV0PXOCoChhFY7qSeAYqVhIzl6y777pukwPU63vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T5mhXjSXGhBru/CwUl3o/8VB45enQth9PxfmFIGhfBQwAf4WtZEpEjMrqv4yxogUDn+uQn74+rWniAL7Q+3Wdtjdya4Vl29H7GjTxUic4pVfj/eW5kZfsFuUOmiFgkiccFamqVDH4+o4TOAK3zFJi7vZe2aROW5SoBugvkZabAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454BnLAw028111;
	Tue, 4 Jun 2024 16:42:25 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-type:date:from:in-reply-to:message-id:mime-versio?=
 =?UTF-8?Q?n:references:subject:to;_s=3Dcorp-2023-11-20;_bh=3DzOF9ubyJMdXy?=
 =?UTF-8?Q?NOijmWuH7/L/+uFUrXzQv+XUdGhoQXI=3D;_b=3DLwPOG2uRu/HImKMnBQ23ayS?=
 =?UTF-8?Q?JDrGy07OiQaDYbWX31Rzuv2ZAWgjwFN/oWWD6S52kWpoJ_n30XdO3rZ+2oIgFSD?=
 =?UTF-8?Q?HfVQYNjEWtz18dUyHw1d42AhjFUgwmZn2P1IJvL1by+Q/MJ16dq_MUc2cW4ahdt?=
 =?UTF-8?Q?NT2rZoj2CyvlS644kT7htyuut54Lb9/XHpmOsNnXbtiXtl5O6hrM6qRZQ_0w5O7?=
 =?UTF-8?Q?ANcsCmdQOD4sC5VhhMm7QfWgvKh+nN2mXrpn9LIWEW8ty71xZY7IqnnxWV8gMO/?=
 =?UTF-8?Q?_n4pqGOXF5lb0wQ4rWwIhlxrq1OAevODIQ+k25UxjtcEws/kw2p83j7x23T9T/9?=
 =?UTF-8?Q?KWqH5M_hg=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv58ddxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 16:42:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454G1657025201;
	Tue, 4 Jun 2024 16:42:23 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrt8vb95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 16:42:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5YzIfDdsiyWxSmOFUaEj7qWKZb3ybwm4B0GbnWBz5dQRwz5vSX/+rlZXpJw2FTDHcq+FVvVNE6Xh4+lulLxWX3lbJA015ERkaI5gdRrvviq6+Txw2A492OUao9tBpeHZca/AulDjV/H9X8TL04X8ULr9NvGMZ3bWayBhDIPToU9nOpCSCAP/xaQ5evJ6ZWds7vu88uLA3D/Lxx+6HRp9CQxzD6JkiNxtWVBsxbNm7UN0HtdjRdJHVWaycYgFuVxltZP9z8noKQqnzwqTXqj4ekrZoNODejuk1mMaSKz3PsyUD0kYHO+nSc/gqoPoROMpaQ6YXiMPm6YvTK+X5NEnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOF9ubyJMdXyNOijmWuH7/L/+uFUrXzQv+XUdGhoQXI=;
 b=cFaSxbZ5d5UYkNQsGEpLAn4qf1qJMKpjRCX3pfhZ4r9Y2Dy2ZzzIcRjQSIDSdtfn3v4b5yWDobN780PPcCwDMEr6aaccQo5U0ATmi+emIlDQkRXBhw98iyYGYxmKyMABY53GLJvhJrZYWZ7zq40RsOk1ubJcFrt6i3Y/KI6e8m84H11p8eNLg9kgp7ScN0oZNAJ8j9vrAPei45SYP6/xID/7zyoL8waVXyreYxpZ4ApTelOtGzEstMs60jI+sDkmBdy2SN7ml2AImufce97OvZ1G9qu/AEejFCjoQRcnKIUWAmdI6/jzOe3Rbi9IXEAd+zK5OyfXTBZiw7ZuWZA8fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOF9ubyJMdXyNOijmWuH7/L/+uFUrXzQv+XUdGhoQXI=;
 b=KqoIbXR0cGZHL0xiJixr//rfJw+j7IhXw9iyR8lZPUbFCyW42mR+KqNw2vRkq00iz6mP3Hv5ii/Mp5eec8Cq4Q7P/1czV5P7cgJYHcxBiQB4aBpPy+a5XhtDOhDSG1sX8SLVKbymDsI8RHNilJXlsLB9UA+ZEFbge1l+x5WgAIY=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB4485.namprd10.prod.outlook.com (2603:10b6:510:41::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 16:42:21 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 16:42:21 +0000
Date: Tue, 4 Jun 2024 12:42:19 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: syzbot <syzbot+c67d06ab25a9bc4adf35@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, maple-tree@lists.infradead.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [maple-tree?] BUG: unable to handle kernel paging
 request in mas_walk
Message-ID: <s5lryzxvwhlyumskluycfm5axyqzpmhqrmx4qiua67uv4y43xj@os4ksxxqm5t2>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	syzbot <syzbot+c67d06ab25a9bc4adf35@syzkaller.appspotmail.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, maple-tree@lists.infradead.org, syzkaller-bugs@googlegroups.com
References: <00000000000066aa68061a072231@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000066aa68061a072231@google.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0395.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::27) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB4485:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd908dc-1742-4168-a4fb-08dc84b54dc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?FSVnt8S2CvW0pg+W3/qgio7Md1ANDqaaYipWvTM6toACKBlnwh/L0m2HojOi?=
 =?us-ascii?Q?+zxJhd9N2JTr8j8RsDNvDdY67V/6CuEbGBcH0+SLjMxM6ihie67EDRSTh15U?=
 =?us-ascii?Q?vZMhLBLrZUe/uETvgbDpHoWi/ewFQiP3JCbCXAjh8gmGSp+KfRocaQGbcGJN?=
 =?us-ascii?Q?IYxsljVZdjY45kJLbCBjQKKnI/RLcNFBGIZkGe10AKqA+m1TWu8bzFlu27OA?=
 =?us-ascii?Q?560Mdcc2guEwaUeW/m/tVk1+pcU13/5uwVK/fkYTSjYRlZQl+Hr+ySYXgglZ?=
 =?us-ascii?Q?5X+e3r+E6m3eqaufJ8P1llGOG1G4A6FLIWRQ5/9QNYcJXyenr+IIIfVxgcoB?=
 =?us-ascii?Q?HMAKJzAkjdgdEeICSG8SFHqWpskd8Gyrx60mAOBohg5kpE72wLYC4Sdx4ClO?=
 =?us-ascii?Q?DdQhbsx33JPCqnUIKv0hoex+uewT0RgYb2zgOgqaxiKp4E0ARcKx0hDSA/GV?=
 =?us-ascii?Q?0ipYLyELYKKl+LcGHhF0UON3NWrYNzL1Mbzd+IATQr4DKszX1VyvAQUSlScr?=
 =?us-ascii?Q?0EhZL/XiAQddeZoEUEo1OotzkPEI7slCCBA2JHnMrF5nqm5pEPBQRQ1Gx8Fc?=
 =?us-ascii?Q?RSg11podQ2kyfrIR35/BOKlithOIKsjYCxDU/zyjgV6ljwmxaV23c6A5OiOI?=
 =?us-ascii?Q?bvX8coeF/c15MgbmRjU05sT7emFfUrxEL1vKFNbkOksYWpzDWZHs8EaIIbr+?=
 =?us-ascii?Q?6ban2+hEZdovfExBqIZK6M0fAuNBLbB3h58+XxAzR1OYRyL2SjKLhB/46cdn?=
 =?us-ascii?Q?mLxw1uAsWB++/iGI04iDdz0rbYO7YYeEcDOpoY7SbjXfhHRxiGsUrn3MNTCa?=
 =?us-ascii?Q?8T66GuuLxNvFHQozcKhOgGmj2YqrYEnV7E+scPYZ7sUlDvCHpz3JSPXxuytZ?=
 =?us-ascii?Q?2ftPVqXMJlfO0vQTmT7jxIzS48NHBQQonIFWrd7I5JeazMS77qyTvc/uKNeO?=
 =?us-ascii?Q?u7Z+mCXdTw0HngQDeG0w1afN3iYs/JiA1ofufCjAQqmq1jHuvjJQJm7CufE+?=
 =?us-ascii?Q?sU3uau4x4+Gmj9W2ExCPZxXdh8wEp/YpStMQFP5puhURL5OQOWphzYKRcYjs?=
 =?us-ascii?Q?/9ohvclnfqi6lDSqdiUo4IZIdPcTaz7norkRZv4NGBJKCy4QPdFNSZDHR9y0?=
 =?us-ascii?Q?tGOLcJOCUqcglYvRFFZiNvfXT8CX/3lxVTWPo+vsYDXErdE32cRbG+mNAXlM?=
 =?us-ascii?Q?JpU63sSfF8eURsqlIMyk1sWi6mjRHQ/zgZzAJYTuGz4yR9rsrU7tMoYMKUc?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Vr7DLRTEIXGAPtUfDZlziV7oTsWNe/KKYGhP1q4SihWerR0ojTIuQxJyERnK?=
 =?us-ascii?Q?OJySrLtGfpJDhyR0AYmxJR+gAx8v5I72sdSt5RT8o3s6HvBIRkLXyttSjQTN?=
 =?us-ascii?Q?OIG8n4SxzpNECvl/wCLYciGvKBbBcb82FSxsa7ETo4vsBSIDvsoiRwzJFUgR?=
 =?us-ascii?Q?sB+MrkwWylUXjkSPrUMRHtjPOq0muv+D6kTjUKZ25XYFCWfuA/I4/a070aEe?=
 =?us-ascii?Q?/0tpcoQRtw9oFwb8+k2yJq2TYmarBGamgT5bVcrd4isNCZIopXULaHXNk6px?=
 =?us-ascii?Q?Ehl4xX8KzyFNFq0Rm8IryaTHoTvQlw2leSPZVNP9sigLL1g/SWvhLx1acm8b?=
 =?us-ascii?Q?KurmP5gCV7gKogbM+AKlGxlEzoEPkrGlJdB/5/wzRKva4jhhof7OozwTN3ni?=
 =?us-ascii?Q?gQdKwgwSTj2ZAAi2BNoRRQSSrQ9oOsPH//WL9HUEdLEySlIYx8b+UsbKPURQ?=
 =?us-ascii?Q?MBkFD8FjkLmr87usaZNTvm475spVo1+A8MaAHq0D0CvaeHu1em0OlM3hm0p8?=
 =?us-ascii?Q?E2pLSBmSR3bgWCSEh2nRRPkMNIu6Kx1R/N2cLV7dkYRTrt/hCK+mAFW5qgMa?=
 =?us-ascii?Q?QGEjfrpICoOIf8ZuLowlEDYJRVRfzOcSbq6b46CA6xTwzPX0ZeoDOfrL1XnZ?=
 =?us-ascii?Q?LrLX8QT0yOxR2do1pUqQPBt7QwJzfiZnQUZ/u3gAOreAWp12d4f9mZab0Txn?=
 =?us-ascii?Q?r4ZEfL7JDs9HxJwnR+9/p2htmGRfON6XsCbRKVE/a6u3ZMKGCl3E525YtWI4?=
 =?us-ascii?Q?p5pJO0I9SID1a1PB3ZHjIXZtsh5xbis34i0PYjBCOL5f+2LsARyRZ94HezrC?=
 =?us-ascii?Q?3jE9rsxn6uABgmILwZkWsGSJAeU4nzW8vi7OJldj24t86sl06GPQyy5v/GQG?=
 =?us-ascii?Q?d5RMG2NMIFJAQ4Et4hP+ebbCsjvucGXeAG9l+0hWauAZXDrC/xd1SQXHFC/s?=
 =?us-ascii?Q?0KiHjsorkSuwV7FfdvAXeIVYCsVM4As6FPEvurU2JHDJn6CdKfJeGn2Xf4ol?=
 =?us-ascii?Q?8tv412cwdNAvRA+9x1w+ljdyDhUOBWiIroAYrhkO8LJsbJFl2po+Ylwp6+Kh?=
 =?us-ascii?Q?pBV87eJzlsJftqjXZ2zKrHO06a/EwITN084d0hy/f2aL6mt03UczkQu14eSW?=
 =?us-ascii?Q?l5W8zwA/cTh+8slpbrsBrj02nfvmHN9qvJzyuWK8aeiuSYiLJ4XtC+d4jDY9?=
 =?us-ascii?Q?IwJbcgtm8W3b0Pxru8GKp+O8OHy4vq3RhfA9BQMwGUXzhLKraxsQroTWfTv+?=
 =?us-ascii?Q?FRakr7OsRfwKW+Bz/uS5Yu2gwqqMd5hPt7FsZ/MkZVl/ru/Ac2ppiGxgT8ND?=
 =?us-ascii?Q?FQyvaV7XC/uN8ovL05Wy9FB7TMrtPHNbakFXGgEc8Jx4xnMikoYdQioPaFZb?=
 =?us-ascii?Q?/qiu8s+PdY3KfMPpWKd5nuA7JSbqn2YLyTrO04Wm12IS87llP0nSc0SfhTZo?=
 =?us-ascii?Q?Cc+u+bJg2SONIysEAY+jN/KKN7ELyGtGLkpByJMOPBrhBQnxJbXUwHEajbQY?=
 =?us-ascii?Q?Gxl7Zcoj7AU2QJyY4pH1YMMJrH31OO4UNnM0VDSY/ggvKJiE4aOYyDEvRSZ6?=
 =?us-ascii?Q?MQTQAIJ0r/oo26DA/QiL3OcRm1vBkDrTI3vmH/B9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	70E5G2YN4BRX7fhyzsFgVpWbbPCOkA927LXML2UCYAfxcX9QM2pzuT4J5cvAWPPMZFKtIg8ZqX5zOH0CCC/E1tnLKON3p4oE4AbkLSMchk/MagjDt1dm8IxPrPawl4PrESlspfqNiIErx0ZSRc/vt2q2KYhJp9hGGAKEY2Kp4C8cCZ5h1gl45x13+GaduktjB5tf2IT82UC5ijJMz1MrDdkUXrZgcBR1gBhhvYzol1HuqEU452FNCT3iITvLMi7RH9pjrwb5NDBeEAXfz0YIAWReAQ93ja/P/ylYUFwj8nVwGqEGdgqqOtRLYFOiIGsQIWPOZvvv4Eo2Lxn1Kib2dw6euKcqfivc+CKgFqAO6IM7R5wal0B/v/ejRzzTEVwepOK7Hk2aVjmJ2gREHVOGf1stvvuDWCSqcpUlKmTSCqj/6eQSEd5jidycTwrrPjjZ/f5dLZZrfdG4K1FL8gWWAW3VA+A/xN7t+RMMiDWetRcqB6v5pLvX4VdVO9AkQPSnk2sXh/xGajjqrciFfqK8RsF/+POcYbfzuF1vN27DWhPlJrJqeQt2GMjDtAl9zPOZis9P8e8sJAEVxJqvWjhJcX6BhTXN6pGW3zB8aFGMUfM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd908dc-1742-4168-a4fb-08dc84b54dc1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 16:42:20.9219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqHRS+rUnRWjUZRjbe7Uwfo6fiv4tQc5QJKFY6r69XbPe7XdXYs/SkSwzLE7INJNjVy31qHZclvsNx1HgJkLNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4485
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040133
X-Proofpoint-ORIG-GUID: fBILTGwLzWX4XhRpvuwZTT-H6_6PPx6b
X-Proofpoint-GUID: fBILTGwLzWX4XhRpvuwZTT-H6_6PPx6b

* syzbot <syzbot+c67d06ab25a9bc4adf35@syzkaller.appspotmail.com> [240603 22:23]:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4a4be1ad3a6e Revert "vfs: Delete the associated dentry whe..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=128638ba980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bd6024aedb15e15c
> dashboard link: https://syzkaller.appspot.com/bug?extid=c67d06ab25a9bc4adf35
> compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=106f71aa980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b4ffc6980000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-4a4be1ad.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/75957361122b/vmlinux-4a4be1ad.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6c766b0ec377/Image-4a4be1ad.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c67d06ab25a9bc4adf35@syzkaller.appspotmail.com
> 
> Unable to handle kernel paging request at virtual address 00700000077b9b78

#sys test git://git.infradead.org/users/jedix/linux-maple.git syz_20240603


