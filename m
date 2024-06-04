Return-Path: <linux-kernel+bounces-201194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306C88FBAC5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B38FB28833C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2175514A4D8;
	Tue,  4 Jun 2024 17:42:45 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DF514D6F8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522964; cv=fail; b=hek1zgfPpgDnBq6N+WITn/zwPvAsEu0DVq0nc0ydfUkyg/OZVXPIPe24ZrnMtEVJtswUm4TmCaiVf8+jqP4V/QnEZ1pydQY0iNG0AVv+TewyUm+KgbXYWsYSGoIizKYPMDveR2YM2mJZukVYYURZ3poTY58ajf/8UPCuk5r3Aiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522964; c=relaxed/simple;
	bh=4qXLWDNNl+1n1S0DbiuNoFIy+bmeWQIVeS7Ikdl6n9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hwSjBVmRRvxM++KqKsuIt5ytmnvigbtq6N1wwlxQJyqlsbXxtn1O2f5tOg0czhYuIwm0tk9YnSsJtFgc0uV5FcyHCObGy+BlY91f88My4VGkpvadbOH3MKuTeITo6kxXLC/eugRqryALnFPjr0Vu/5UGYaxi3i3PuF55u9tZ2Gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454BneW7026963;
	Tue, 4 Jun 2024 17:42:25 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DPmOkY5uADHU69ozTyLP7cB1Ob5n4YcKEW7gbl4Eh+y4=3D;_b?=
 =?UTF-8?Q?=3DUgwBhLyXcxXZCTDkHc5e4lh8htUFNwNUGJIKhHWaPEmdLx1KidtME//HZhl3?=
 =?UTF-8?Q?X9W6DBS4_iV41prM+mD+KrolPYFYw/2Qvu94CNr2q99KJP3pjGIFqAEFCi0d3yf?=
 =?UTF-8?Q?NvAkBTOWFtcwQc_t/G6+f2HPlhqeYIyJv6T6xY6qqEeH91KjkJwm7ctdhxbgSuN?=
 =?UTF-8?Q?PcWaBu1jtQkeHjvtrTh9_eAwE0fa/GhN5CCzb+9lK+Zl0hZ4/zbg38V+wc45V1Z?=
 =?UTF-8?Q?1ALSmTpDwEQjIUfbvBMI/RZQNt_UkJNOiJXEubNwO//IxOmFfYguLjeP33f/BMf?=
 =?UTF-8?Q?+IEVjH4SNJy+oQz+2etk+qfrIgUJYArS_gw=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv07wjyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:24 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454HCsqT020553;
	Tue, 4 Jun 2024 17:42:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrj2bmjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mtqasz5RuwN4Abju39lAXe5HRYFnvAQciEQWjejT0cU3Qc7qzEHoMX6/YL97gYj2ORYNIKvnupNrV+WlBSbKoXvzUmf4AIILiGULpLZTCO4wazVsvzSsUVpyZkgsTlyWT07NpM0tCP7UNvfF5/rkAq3RjPK6+MDJF0XMqbOUFo1O52sFpaMdySuOl2oUwJfeJx3w/it9wJ5URUrJt7K6gHICuS9M7697Dv/dRkWN9NG8YI/XMycVtkWMyTGB3GQWupPsq929Zv622qthKzKRr08bm1MCgc5jl378E0OkHPtws5tilx5rL37jck3vVUW9VjqzfmFQQOkeyTgnxbobwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmOkY5uADHU69ozTyLP7cB1Ob5n4YcKEW7gbl4Eh+y4=;
 b=eakLP0NoaAblN6z1znqY73s44l0JP3E0O4sHmK4E5kdw4b55rJjVFNX2TYAPRVlo+UljQGdWaV0K39OzPSixNEygqoOOLOyQ8Z3H3ZQw+myYubXL6hBlW4eWDuXWOjOmuV5oMUuQ+lztb+yygojhBwdVj0tLvqBUTNECUtj/s9b+dVt7QIV4VhCPMbUyTK1L1JJfshxeCtlsypL42fLgz2snkOBNbVX8gMbjUQ566TD55tVH9JBkDCS3imTl7tW9ov/d/TxzCWMqcZZ9FJzZb533GmeONEaA2IAw6coINu07mmFwXu2LFy4sfWgeEqsOmkZTbyr50bmtk3SIFy2SoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmOkY5uADHU69ozTyLP7cB1Ob5n4YcKEW7gbl4Eh+y4=;
 b=rpv4Aga6sfD+G0Ng8X/+W/WoLckFI0C74e8/rwQ3LqgmIlSGcNbx1a5Fz1YKSIOfDaakplm35Wz4YFLcauz5MdxYYNDFpBzcaU9FePgLc+J8zF0w9nKSkmNZPhMyiIGbu86LNYnOc/LDC+qdZm34O11M0buuzr935600tj9rMEk=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Tue, 4 Jun
 2024 17:42:21 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 17:42:21 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        zhangpeng.00@bytedance.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 14/18] maple_tree: remove mas_wr_modify()
Date: Tue,  4 Jun 2024 10:41:41 -0700
Message-ID: <20240604174145.563900-15-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
References: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::7) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH0PR10MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 90ee5abf-e6a7-4e06-dff6-08dc84bdafbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ckn6NwjpeA2wr8c2K6e3ayuHD+v3OB3CS3/zsLWDjWDL61n6g5vTHDKrPL5M?=
 =?us-ascii?Q?ObsivVTAkc2WsNL0Wzy2mQ1Wy+y2UZ6eqK73VK7KdtkcpQBFZg0uujD71boZ?=
 =?us-ascii?Q?h7tVMk7dQdPEi6F9rTTIE870bAa1IrbBVhQaMx4REyEIPeglpNjLiQKg4uHS?=
 =?us-ascii?Q?hFGFWPdiBhXDql7kKdwy0Hfb5bMyHCgdnKVxcPTB2O5xKskDOu6d5cNopksL?=
 =?us-ascii?Q?pDWj/OIg80GZx170NsXeg8SGOAvTKjAsPAjXw2EW69JQh1JFnfCR3X3Pr98w?=
 =?us-ascii?Q?dEuwMbWNp6z5xBn80Y69s6zQbR+ghG+l4DwQgghJw9AGzV/ZA3nFrSG0EvRc?=
 =?us-ascii?Q?bLF6UPzD7qbSlLP0kPzpWzW0jujJr/bQzrZ28Yzd2xAqlQ/NblCOvhP/+nFW?=
 =?us-ascii?Q?NXEnXkqn90uVOFZgKAAINEOEWk1C+UiFoZhubKyZMoin8sO0j8PZJNE8ZAUJ?=
 =?us-ascii?Q?cG/+e50QxZ+a0qrzF0H8ntq8Ebt2QkbCwZobxFrIN6HSsvlkbzcVLwhuCdv+?=
 =?us-ascii?Q?fJmome2Ey4N/vcairAmRrklG4zC7GIJVnJTiIWsUIyl7xVdkiY4XrwVrMSze?=
 =?us-ascii?Q?r6Ip1bMLcBnJZdbOSMagFkTMiX6mC7Fg1/esuujm0LgZIQrQFdePrl/pvNPB?=
 =?us-ascii?Q?PwH7iJplVNyAH50IrSz511LDsZmSYokgz074FaX0of+T+LVwS3u0JYUCJk9j?=
 =?us-ascii?Q?2/uJ75NhfDgtUWl+MX8hqMPnwfVyUzWCg6Su3uNFhZhJUlFVTM/IfOVZSIv2?=
 =?us-ascii?Q?JFw6orulal6tuEgjJ5cm7Uh+paqxDZFoiGpFn73792hi4qcFTrQ3A+Ehl0gq?=
 =?us-ascii?Q?fJD86wLRznHKm2V/kzuqcBx/YTyexAv0FydWiVZ83J4oeGELFJfs/KX53Q2c?=
 =?us-ascii?Q?ChGJTeqas93spXhdtIYCQ0h1G9E6WvfMhMz6kcPBp4D8AdkL5XvRPJOmhjDQ?=
 =?us-ascii?Q?XJzt1te5FdWA+ka6BA5r+STbGPz5akI7cuuMElhlpFrgBvwjeeZOu7vQAr6s?=
 =?us-ascii?Q?5cLipg7GKeVJCgfyynTS5AVVfiIgagqmxEn4lOMr5duyov4xK52omtZbs63d?=
 =?us-ascii?Q?ApcvwF+c+EkeUuPVDWI0jjfm2YyeCNO7ONG0mJZW6vKcdh/ZIY/goF9HBuou?=
 =?us-ascii?Q?MxU2yh5QFx/RLkJ23otHJVkBpI1SBi82XnI2uuT/Uja3e+yma+UBhFgBe/YA?=
 =?us-ascii?Q?twA6h+PuLt+f7HFHVd7UdxFgUUJY3XvqzMpEZKqj/IE1RMgn59n+vZ8joDXR?=
 =?us-ascii?Q?H2GHm/0jysFrxy7uPYldDEq/JdRQ9FCue/DHq4L/Jka2Z0DBDFnaKmq9ZOtB?=
 =?us-ascii?Q?tMU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?r0pWn5+nKiqB1zurAQZFl3/3fINdf823dORO2h/V2jCBWXZ67ln1Pw9EXHF7?=
 =?us-ascii?Q?WUbIqGXKvXgnay3iiUNS/7Clw/vcCaY4pP7Fb7b+bFDA+JsDTKzK7o8he09F?=
 =?us-ascii?Q?c/a0mTqUkhsyzkA4hxV+tThpEQOdyxm0Oni7g8CIcbq45uBMtKdxrQHVXgmQ?=
 =?us-ascii?Q?OrpBOlMJrepxD0gq5b/MJ5Q70uMQNtHP+aWJ/WAPmyCfQldKFBrdpCbMz3kY?=
 =?us-ascii?Q?jsF4nY5oJ/TjEkQC+x1w4TrXxtw1SenA/MLphYAStWGMn31hVkBItgRw3xGu?=
 =?us-ascii?Q?H2x6tVWZ5nP9VCX+YFv/yu9mtma4LW13vEiRRj3G08Bnn5kW0OUxHx1eGbgp?=
 =?us-ascii?Q?kL3b6DClJiXBiSyet4DShy8bAYelUnZEzBcy4oGsAmtC6rHNDQ3etQp5I1AT?=
 =?us-ascii?Q?u32EUXt7XDKQSGGle0klyr3gIeRajP1VYLdQzDgkatPy3jz1vatLDs0W6NT2?=
 =?us-ascii?Q?oycoX5fAn1XzOdKN2AvjXXpvg5lVj75yN71cgeW/7I7yRfI5f+tcWqgQIUEY?=
 =?us-ascii?Q?380aIx6i8kVqHHFH3CaEx5Z3WSpoEMPUFdpPh8Rc9FSUzl4ulP/98KVZwHi2?=
 =?us-ascii?Q?0H24DNW/9PI8s1CWBL3OaooJqVTEAt02pWopx0wTkzd9d0V6PpO1Bb4yYFQ+?=
 =?us-ascii?Q?63y8EeRjfsf79a8E48w58Vv09Hf/DycAlns1iBmVwF5IIfxZ5/UGEK4hWQB7?=
 =?us-ascii?Q?zuy1IMLAJRLdQ4QtZO8bNS9z23V6k6YYXz/XiH89s82Qz3Pv39pUIOqD5KWU?=
 =?us-ascii?Q?u2MfGSliKJePjO91Zwzp6ih5udiUVAyYtqP+OleGroiyoMF4oGpypirNfd9e?=
 =?us-ascii?Q?zdPDnfS4x0sY6nmqWCc2NOwnydhaojAG6ANTmFuxcqeAkRjgK5cpB/RuK8it?=
 =?us-ascii?Q?hnIz8Dx8+tOVw5i7STtYecY15sd3vwUfB/HrmgEdNq+l1rzh+oq7Ar1DTVxf?=
 =?us-ascii?Q?I5SG0LcpY+tKbojQJ81ZKUPO4RlFKiyDhrCkxK2AomwA3STrtiesAYudJ96Y?=
 =?us-ascii?Q?iYGgCrqPU5179HtgRxl5SAj+Ztt5x0KJjibM0pMZfChbNeP4hSiMtlaUhFEo?=
 =?us-ascii?Q?omNNHG/wgr7g7QdI6UKspeUGWzNOLSw1BUaHoEy9ba7fPNQkfE2GDh1dtfZz?=
 =?us-ascii?Q?62x3RKNjjVxrGh4NhqBhdMSOnd981vp7M2E1j3Onbmc/xsjilPaBjIPZ8/2R?=
 =?us-ascii?Q?vUG1oGF3poFPT6GrEsWecPFRFvfz8VwU30y9A1PcaW1IKCd0P7izcDW9By9e?=
 =?us-ascii?Q?72tlfrPMYbbQjnT2vBrFuBoS5UqWvFmZmGMTa+Ge0NxdOkT9gkYCNvGjCnCP?=
 =?us-ascii?Q?2lV9W5wi8vmqj8wkc44islyn8qVjRqimObnBG+xpK4Z8WjatZRLFYeDIbGdF?=
 =?us-ascii?Q?ILsVvQnPx90gLvU3TrPhyZj4dIQtfjL2Eirpe7EnwjvFI8+5zRfumT5RDMxY?=
 =?us-ascii?Q?vofyBGdIw6a/UaqEH3RH42pc5oYOqIxbQX8dJVue41oaSVv1RaYF/5arEzis?=
 =?us-ascii?Q?PR75wH+6ItASVXpUU2CUed6V2fJcUCRaNXC8HxTfEbcL1eJ3QZbWWlSDiTG0?=
 =?us-ascii?Q?MW/fnyvigCmO8j8tb38hYOJuobqmTo+gE3SYSME0idCHKnGkKBtgU4GmEJeH?=
 =?us-ascii?Q?zi7zx6gXXWnGYc6tI8kWA9I=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	AKKC8uLLziVrpPjiLlJeGoCQI8I8qzZcsJ5M7SbfU3zqu5tAn6S96XDvxVSIkK4mxJ/cZj1EIiEMHwih1XuaGQv3+6dDY9h2WivkluXvMyuTqVdGftOVPnAmY0QgdRwlTfwplFhbvJ7OCSXIFDtkbtSyBVmxyz3OlWcnio7nXnzKf1C7DreqLEnE/bLFM43aSWpzJXAoCZQRxADJ597Wxo0f4J68L/I65VkPmBBhW5O8QQCbSMZt40VEwUd22GC3B1Ew4PJJFhht1qxGYjy98I4JgEgOBe5Fez/oZ+2UIzjLDpfuCG3pA+rlNAVSlo8SF37fwS94XkuDdLVRwlorwAMFplPypgMXkVk4NlAbwTIZ1mL1VoEkgoCBuSDAr3QiCkf7CLNWMUhcSDlP0RFayGtYcs4NIx2jP3v3RO9AFB0S48WglCY8qRNyhd8rkhwnDQxhboaycMLL3NUF+H5Z+CVJf23tjRwSjkZV0F5j/Ekr/H/Tgm0u7JtrqeiQlAgAqv+4SBsXC33560WD9MZTDoxnKTunJ6f8AQYowhyT//r20gYi9mxh90Ii3Xg3++AdegrWU05dxD+8SLMYYs69kSzTkO1Ws7iR+MbqNVmIEEQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ee5abf-e6a7-4e06-dff6-08dc84bdafbf
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 17:42:21.6149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ox6citQADmsN/7xFaUUz01HdyZy0ppGJzdOhZ4mp1iftmLAlaZQrBBiEJAxbUTEXDHBGNQg7FuZ/YwfPCTmbqxwi84eWGojoTNoy8zIJuc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5893
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040142
X-Proofpoint-GUID: YfQEzQo8Ys4uGqUOXfb-ed01T_5hyxdl
X-Proofpoint-ORIG-GUID: YfQEzQo8Ys4uGqUOXfb-ed01T_5hyxdl

There are no more users of the function, safely remove it.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 38 --------------------------------------
 1 file changed, 38 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index faadddbe2086..74c89aad8bca 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4156,44 +4156,6 @@ static void mas_wr_bnode(struct ma_wr_state *wr_mas)
 	mas_commit_b_node(wr_mas, &b_node, wr_mas->mas->end);
 }
 
-static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
-{
-	struct ma_state *mas = wr_mas->mas;
-	unsigned char new_end;
-
-	/* Direct replacement */
-	if (wr_mas->r_min == mas->index && wr_mas->r_max == mas->last) {
-		rcu_assign_pointer(wr_mas->slots[mas->offset], wr_mas->entry);
-		if (!!wr_mas->entry ^ !!wr_mas->content)
-			mas_update_gap(mas);
-		return;
-	}
-
-	/*
-	 * new_end exceeds the size of the maple node and cannot enter the fast
-	 * path.
-	 */
-	new_end = mas_wr_new_end(wr_mas);
-	if (new_end >= mt_slots[wr_mas->type])
-		goto slow_path;
-
-	/* Attempt to append */
-	if (mas_wr_append(wr_mas, new_end))
-		return;
-
-	if (new_end == mas->end && mas_wr_slot_store(wr_mas))
-		return;
-
-	if (mas_wr_node_store(wr_mas, new_end))
-		return;
-
-	if (mas_is_err(mas))
-		return;
-
-slow_path:
-	mas_wr_bnode(wr_mas);
-}
-
 /*
  * mas_wr_store_entry() - Internal call to store a value
  * @mas: The maple state
-- 
2.45.1


