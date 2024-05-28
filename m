Return-Path: <linux-kernel+bounces-191547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5623D8D10EA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D075281FAC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D487BDF6B;
	Tue, 28 May 2024 00:36:05 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937BB8BE5
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856565; cv=fail; b=H5E75fBVWRbC8A9KoOIog9O7N4t1P1GVViMs4vCFn4eeTVe+bnmydQajTFIGsuET1lKC3Ee+5BAd+mq4kKVjCOxz0k7yTVnqCFdGZKtrJGbrSi6EJBXy0VvlKsUHSLSfHkSkaUdsAZCEEUHAbwFwQNy+4y/A+xQb61LjkPe07xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856565; c=relaxed/simple;
	bh=5pwWADmcXuB/Q43iIB5mDD6ECsi2gDN5xGgxgdXErmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Myo7cQcy2dEJ0C69fYzad+Q4fRcq9sNJ15I5hDA9pA2HF6+EKQiPECdiJ9anH35QDXVEuWkXSQk5QqJK+46Q6Wwl4BLp7sr/CIhY7QZUVZTE8EjQpsbAIGQD2BghN+vkFbLFGtT2z6hEmCqtnFYdM6gX+1+vbcXF/sUQFkfWQKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RDI41Y025151;
	Tue, 28 May 2024 00:35:39 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3Doh8+0pNsBYMSdecJVTsGQKkjpyuMNwOgO08jdsDBFL8=3D;_b?=
 =?UTF-8?Q?=3DIH4xWbs0pbGIpjpeDaaS9gsQQjyy54TOT2o80RA9IS21XhilZQ02nsNTZ9ti?=
 =?UTF-8?Q?i/Ws/jUb_Py8UrRZVfmg2Jsj4kS/vR+3NKg4JMiPxym5PAddTlgyKc41PuIZFNX?=
 =?UTF-8?Q?p+oFc25AFaPcxh_THuIDzupq9Js9HwY4fXG8rubk35ORyT7ysPoT1Adkb6ZFsOC?=
 =?UTF-8?Q?qjOLMVgG0pZgHBc9ZyPM_6z3saz/Saio0QNB15fxHinqtCxKQGYu/bWONM05OUW?=
 =?UTF-8?Q?EUE2wp8SsffsIkXNhUg++QTl+J_LtETCszEhUJfgvHNezGVmJmLQNhaLNUhp0LN?=
 =?UTF-8?Q?YBP3VSYhIumzcDNxYIe6h/5uYxFuWgsF_gQ=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8hg39aj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:35:38 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RKwWGQ025813;
	Tue, 28 May 2024 00:35:38 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50p7x23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:35:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmvpw2KxJEkXvuwlg+kwL16iwo4+NrSLGjaKOhJxf/GWP8w4Ncm5dvdfJAwzsBPiq3O/tK9qMNpaFc5M9d+t2sx1LmIvj06SDI0XBLe8rWmS8CbjR5RP4zGhdzBfuAe23MydOiLf7MhjdgUE7T1/JaSylEwaAZmn8bz5c1soqMkjxIyXorGy15e0ioYORo1Rru/2Qt9pODusu9yF5ZQzzZvR3eVsrs/X8oYW9l1pmw80j5V8FRY7jda9zwzojcB3KOPCNAaikVHLMklUebQpi2/02sW9dEYP1Q4PRHBIu6qM+jU3ZjqPrE5YyLrqMSGfau6VnldoQAmcSTmhjzlKvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oh8+0pNsBYMSdecJVTsGQKkjpyuMNwOgO08jdsDBFL8=;
 b=CP7rJnxS89TytOLMNmIWoSvE6uEBSDn3Ierp+TpR57l65+gT9MxfXWPK+cd/QHS2IO/paJhcaBDaO+cD/jM0kJIAeWUiaFXqne7UiSdNPa2q3JoyRYMokPsK4fiB7l4cNbkv+NjGCs+QsBe2r1AaoB3rGylREB7p9f6sVFot2U+oS9UCAFpWMZWCatkReurV7TK6PC1OYk1TH6e1uEDKSfilQicRxX9i3s9XHjePDq66qsBCpsAFqAKG9VslcsseESHae12UPwNzfnGR9MNRSzkr1XtFtLpkvraIHr2FtYuvrkoeBD/KYEen8Ap4ByCqP3JR43WogP7WBYeFoKG8yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oh8+0pNsBYMSdecJVTsGQKkjpyuMNwOgO08jdsDBFL8=;
 b=Uaq8wTvviy2n1jqeDSFunpahGvQSkuXK0CX1YJKgDBdU3YATDUks1jkvWJ0LIGBDysS/71Wl7IwRuS9AG5sV3ySIC2kztOPe7I+zvcucXFgu1QFPPM8e8X3N+CoESa1LYtAfgn89NUi7O8D5zyLxN1V8qkeB/X6Wo3/cT/t4zfs=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW4PR10MB6510.namprd10.prod.outlook.com (2603:10b6:303:224::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:35:35 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:35:35 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v2 03/35] sched: make test_*_tsk_thread_flag() return bool
Date: Mon, 27 May 2024 17:34:49 -0700
Message-Id: <20240528003521.979836-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0317.namprd03.prod.outlook.com
 (2603:10b6:303:dd::22) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW4PR10MB6510:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c5f899f-0336-47a0-f7ee-08dc7eae16d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?BhPkCVw83zl7SuvMybj6WeIZrSfSmDDDgjrp2+PcUIUUC8+K2KXvBNOuX4j7?=
 =?us-ascii?Q?Mh/6p0/MbW3FsaBChCuVr9aFZ1ts+JdNijdbNbQRgs0/0SkFdP+MNLvfoddt?=
 =?us-ascii?Q?ElRSC+LX9Ztxy8sB2Mp73L4651ptpJWPflYbFECrQ8SwDTHRCdAy/jNW4Luh?=
 =?us-ascii?Q?xSNlw/QFOxz+7004PFELZbixmw77/WIH7lY3lW6JoRmxtmxxgCnyoxLdZTFt?=
 =?us-ascii?Q?8g/NaQE2bZJjbIL4uo9d0CRfSPCB8Dj/Ob50xo2AtVqZZg05IOClVku+QLI4?=
 =?us-ascii?Q?67RhGIfOAGd9vjKmUFxnbWAGDQpGeiRxunC2nzTroq1gjAcFLTyupkx9Cub8?=
 =?us-ascii?Q?VnKrt+EIaOA8u+8sk6ypKhGE1gGkVnROpfbxnF7PuafF2aEcbYTzhJowcpe6?=
 =?us-ascii?Q?wcUSzSopy0ZAgtX7reFcdpsssS2mUme4snKDBlWuLJhHJT2tQkl4suu3gauE?=
 =?us-ascii?Q?upqOXJ+/u9nQTL4HGZ7NzqOwvnz+nGuks5EXeFih+oHoIEPuV8ppTgJ6e9z0?=
 =?us-ascii?Q?5AvaQkhuN/5w/Ng1FbmAjuQozZyRoA6K7uJPoyQEsBMf4OWVFbFruTMD991K?=
 =?us-ascii?Q?im5G+pk7nqpwG6lwiFBDbc7jL556Q4v+oczzZS9mjZ6ORM6mVvBzcOHi8urP?=
 =?us-ascii?Q?tInFqukK2msSSB5tPy88aSejdfW0digOq2rHXwLAy6JgHD9E7qUcrZ83nDBV?=
 =?us-ascii?Q?7avtxIFhGQ/XyR8Xowa3AhiUrUTffCQPZwA9GChtQQyaQoyzvZWM91WJb0e+?=
 =?us-ascii?Q?n2redsGFf73Hqg3hdn6jpZp6Jji+f1u5I2XkWsit7q2AZjcdPmBeuq07zYmN?=
 =?us-ascii?Q?KFkhXwgeZooyM4eRbSbfDvNQVGpZ0AWSxcOQn6aJ+kewTDdIgCevPzZVyAyF?=
 =?us-ascii?Q?CxisFy4StdDYtnKp3/U9j+GGeL146Hv6kbmzj4ba6uIi/jHmE3cMEPcOt5HP?=
 =?us-ascii?Q?oZYlNeZmeP37SqRb0bWT1W5l/qriZKS8nyCrULa7o+f5oezQZic7jP8K9fy0?=
 =?us-ascii?Q?hzK1KzlwVftgSM8AScMOzrwQ0YlMYK9EigbFedT1Go4KW7ENdWbHmXR/mNf4?=
 =?us-ascii?Q?TTH8ySt7LhbSPQh2+nAIKF/tsIljAFHhaTefao3FbB2n4kLPyLQS6U+jrQQR?=
 =?us-ascii?Q?MDHxSoHARHER7OGmRPMtBfj+793+/NBuZIyEXpqRUijKUOJUc/LZbomOKkM/?=
 =?us-ascii?Q?BgoUXPUN4VcOyiVnTGPgnggoR/t83eLFqWGR/RKnUrNLBZQY0dB4e+mqzQM?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KE/KRskRe4fFTuuCS4Uud12VQLJ7jUnGBxtVnhVDQKmba3hA1ySs5EwZOx6y?=
 =?us-ascii?Q?y7FVd2/AaMpaombaoRWEP2cmh1abS9ieeDnEKb+MgC4fE/0PGu+O4t0O4OCu?=
 =?us-ascii?Q?s/M3285mEYBLGwtPd2907WTEudPy7JCJKLi5XhCBuaWNYWSKyt3d+8vUO2kJ?=
 =?us-ascii?Q?UANZkryd/JKHI4VDhLbP8hYzuq+6RpY6M9JAcdaB3GJiepVQFYRDZQFRlynh?=
 =?us-ascii?Q?X0JiqXCRaBqMYH4n1aEeCmm9AkXMhHwS2qJ+HxDJegOD209q1YlwTN69LfOA?=
 =?us-ascii?Q?7iZuytnylsG4U+JWpr7B2GInV72R8cj2bvA+rLGD+yWjYyXbl03p8XLyPTec?=
 =?us-ascii?Q?lTg+o0DMjAbd76mlsBC1hlXJNXUq0IN5zJ7FjXJ6FYNYZ/KTxy3tdn00QL+b?=
 =?us-ascii?Q?4w00OcO3R7bBVQgCAKJPuOX9L8ex8Lo9JKohPoUDa7iW+iACZH2HWO3xZYPn?=
 =?us-ascii?Q?83lfzWe97ylqvfTYhdWor5qQ/qpnYhGA/IAeMSJe2FxOq4s7cCxBJ8H3lq5l?=
 =?us-ascii?Q?ZabAZRcUugvGENbVatfBuWLFMG/ho7vpSqvp9RXN7kCxiwBPLJ43WSFLYNeY?=
 =?us-ascii?Q?9JBCMbCA6atBBL2CZrnKn8Pz+Hr/c0CTZXe4SNJGSjlOUbaGvYEijoVjqbW9?=
 =?us-ascii?Q?VjHwltfp4qPN0ohCFoZS5Gbz5vN7HPHCZ9nC7ubkaNlM84mLIqg+n3tJoZ22?=
 =?us-ascii?Q?t79eFBxPDpKz65zfbRSyXR4MPW1Lvhx1hemFBPBsJb33N40EaWbzfPhyfX8R?=
 =?us-ascii?Q?u6HRxCEXxnqJIwcV7OgqB6nlFrY5mzcVXEaAXykl3a45XtGtxjMa0kIHDI2y?=
 =?us-ascii?Q?5F80wdCsZXwuDAZbCLTHlqzidWBoUsQVchJHI72vLfzdVBVVL6zv/xdlnvPW?=
 =?us-ascii?Q?OGiEzTeV90kPYXtO2l0BX5qoo/P2aUMC3Ht001Ba25kxI+ArOAIeVJjZT9rW?=
 =?us-ascii?Q?YaR+dI8qYXy5r1tfUcSb8K46zaVemPOEjOmFqs25AAJVVS7EW9xusA1DVH55?=
 =?us-ascii?Q?G+et3CRD43HBCJAO0AuGyX3eRPxE71KfGHeF62kPU7fi5pErDz+URYtvZint?=
 =?us-ascii?Q?e/K8DRWN4Wbvgj5mPpVf3RrJrUlC6Jg0Uw6sNOGGc91J5KgsxN5IVAPogqu4?=
 =?us-ascii?Q?DlX8IqRf7+Nd/uWFJOSgIytIjw+3a58CXXRylc5HZ/wIsEg8HFIzcSIPN4AV?=
 =?us-ascii?Q?4pPrZryDpfH/HbXpClIJg+JgI3G7aLtcD7YYcEcwKqKx82v0KHl0nB9toO/L?=
 =?us-ascii?Q?PvA/c/6Tvpcr3ytbW+BVfJVVsI3/L5nHquElrvodbgtxjgNea42oCWKXaVjk?=
 =?us-ascii?Q?47RI13ds1U8s5yHPCOk1J9/7IYmf4wmaa4kjIlDrC8XpqNtLjuGH8gMFvXla?=
 =?us-ascii?Q?i6kasI5TPhDnQmdIfnsBYDmOQtCP8F4ihrU9qj7CqwnLPkjHfJgNG/lmO4Cu?=
 =?us-ascii?Q?8t00yVqjweVunbTRZ5GWFR9C4y4rJ60xk6ZBlgPOrsVgii1adiETRxGD24qq?=
 =?us-ascii?Q?81hcnnOrPsFpYURAUXsxLfROSgECpb3nThYAHakcpuk0vZi2WFjgEDu2CMLR?=
 =?us-ascii?Q?lSFNQwXTZgTdwAoW6NSFD1pRvh3QkDhMiTuCpsUxOVm5ssPUOPb31e+hkGE8?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wPcGx3WphRv5sS95XAGqRxx3/bq0/r3LzsIwwkLD1rJpo/BVimf3IF31xSgaDS2BF9QTBg6RjBmaue1OHogUVbFtFnnNDzlrS/VoEYIZTdXuY7Cab2XTNdvY1tHPE2FO37pCLvpAqYnrTwdZR2YsJymak4HiQzk4ozuU9VPDWPjbHc3K0OxMHkIPREnQBPu0muf5bD8w/0MJ3u5gWb8qnlHHloH9gofqwhk+lW1x+V6Oq+alK/EAE/YUVzAhRbLkBEYOKtcIIXGPJo87xm1v5Sg5CFGma3vac+tk4jiWAdsiCEOa+cK2yNOe72xGfHsZId9D4sWZ6Wq6HbVbJ111Xoyq+oWmh77Gb4IIwxRnyP+ynAPO1IKeF3RpPiCdjk6yeQh01tve0VfGW8VGAlknw+D+VbbJCS+gcmJVmWwDHcK3mWJGYJz5kAPyRkGuE7ua0uUarb6t+nahpMrIQsniQk2ry7PpaZtlQBZdeBeh3jCitVrUPnwzRVVCIBy8isu3Ck5jzcrT9ufu03ABF8u1wt2cNoAjF8dIxjkSHb9WRCQqqtQ8L0f+C7Tkxn6OxOsiZvFpx5wX27T9IF5Lx/+MmbPYpzXf/lHUqsmtjZEiiCg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5f899f-0336-47a0-f7ee-08dc7eae16d8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:35:35.7649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxG9fzBkrFtkfHrSTpnJB1/8C54J8OuUiTC3Su6bVG5h4xjv19fkgx7lV3xr6Jhz14geY+R+26Do5twzmNm8+6Pjmi5Xl35SRIkyXbCj+3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6510
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280003
X-Proofpoint-GUID: 6kkzXL2AOwXXBCOOrklisDGk2QOS5_kG
X-Proofpoint-ORIG-GUID: 6kkzXL2AOwXXBCOOrklisDGk2QOS5_kG

All users of test_*_tsk_thread_flag() treat the result as boolean.
This is also true for the underlying test_and_*_bit() operations.

Change the return type to bool.

Cc: Peter Ziljstra <peterz@infradead.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 include/linux/sched.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 73a3402843c6..4808e5dd4f69 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1937,17 +1937,17 @@ static inline void update_tsk_thread_flag(struct task_struct *tsk, int flag,
 	update_ti_thread_flag(task_thread_info(tsk), flag, value);
 }
 
-static inline int test_and_set_tsk_thread_flag(struct task_struct *tsk, int flag)
+static inline bool test_and_set_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
 	return test_and_set_ti_thread_flag(task_thread_info(tsk), flag);
 }
 
-static inline int test_and_clear_tsk_thread_flag(struct task_struct *tsk, int flag)
+static inline bool test_and_clear_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
 	return test_and_clear_ti_thread_flag(task_thread_info(tsk), flag);
 }
 
-static inline int test_tsk_thread_flag(struct task_struct *tsk, int flag)
+static inline bool test_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
 	return test_ti_thread_flag(task_thread_info(tsk), flag);
 }
@@ -1962,7 +1962,7 @@ static inline void clear_tsk_need_resched(struct task_struct *tsk)
 	clear_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
 }
 
-static inline int test_tsk_need_resched(struct task_struct *tsk)
+static inline bool test_tsk_need_resched(struct task_struct *tsk)
 {
 	return unlikely(test_tsk_thread_flag(tsk,TIF_NEED_RESCHED));
 }
-- 
2.31.1


