Return-Path: <linux-kernel+bounces-349504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF3498F709
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D5EE28300C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFED1AAE22;
	Thu,  3 Oct 2024 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LXEXYQ+l";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vk7JZJ1V"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D464D1A4F11
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 19:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727983990; cv=fail; b=MFU9NIQmW+AQ7Iwjm1dGZdmxd7v1f249+GtSPEnLaxM1vbz7Kpo+lRIQ1P8mygkGXX03xKtKE95vKZb/93HMwqDNsDUd52S3BNQvRo2sWlH5MPUbUbFLTjhk+wc0aMmlZ9vAEyjOhZYLPFDYifPL1qcqLqzKXExbuxU8JeOIppw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727983990; c=relaxed/simple;
	bh=KEIKAcAN4lMPF+XjGzyYDrjABX6cFK6aPpe6dAxKMNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bhO1P4dqliuqH+ZYoDy2Gyr3atwTpU32T8DTkE0UD+mRuzz/x8nDrKALfi5XV/M12SVg5bwxw0vprieB8khACg/SR3WfwsKEZv/JW+RNm1hs457JNckVwz1eLWO1LRN4gvI2Vg7SlFeix7tqnmFLXE3ndxy3YjsUgZouvrfkVEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LXEXYQ+l; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vk7JZJ1V; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493HwOgP022144;
	Thu, 3 Oct 2024 19:33:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=KEIKAcAN4lMPF+X
	jGzyYDrjABX6cFK6aPpe6dAxKMNE=; b=LXEXYQ+lPFjabf8oaqgGmTsVsH0UlMQ
	aA76vh3QR2/3Bz1hB0zqrvBXsYTD+sEmCIHuRdPXiALQwvQyUEpLqF6YluBm9Byy
	Rd5P0mVImmxw/Yk1lyyjkz6HUqH62C7FxbKhEeiDub9pZOmzSaOR3CuneOsFAobP
	pyfr1arO2l1lMx+knCgc7z5DJpVjqUZhHTL9d522t03xYxa0m7ChA3fRZ9JhaS17
	uqVTMXlDhHbeYjfYH5M5FDiRfASdFJOUKGqtTaSdSzW4b5vRROIioQiiWoz0p1KW
	YwZDEAOSG+fagGW79FLVoj77b3qEmp/Kp1obZ1hZFxFdY1w+lK5pVvg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42204fr71s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 19:33:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 493HwpOe005842;
	Thu, 3 Oct 2024 19:33:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422055kkgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 19:33:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cStKgMFDg7+99H5VC6VGUvKqd9ISxnpXWbimzm6eJ54OGKi7TsZKlvrx77tdEDYlSfRGgoFsET53wLp8OBnU8XRmjKqbRoTmRY+Ul1bNVDTI1TidLvDGaSrdy/QeiIjE+TRWH5liqyzAFJYVK7FyR06fhlUdcm+VOrvkVgauCzf5tIMs/H9zToQMC7HakzdaXmF76vWKhX6BsbK1Wb77YBImAuO28GnH2c8srLb7TGKzwGln2n0/xnat3cmBJDvLlpQuaG5445otj7dwqkczOTOh0Knam6cWVu+QRCv32rF+5xBLztoX2fzCu5YxGft4kj3KgFFsD9ElpAbxSRI4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEIKAcAN4lMPF+XjGzyYDrjABX6cFK6aPpe6dAxKMNE=;
 b=pV4qFkpSpa/GMt/iTKQCSbK8xpZuoSvYrn6AjEJPE8uCQXEPyGZDlVS/qwAz7iVQxBJy2lxqPCyAi97k6regMPjwS2iHH+wL2+9nrMzE19anVXU8qqWiThTWNwXNlz/GkOTkiD7XtXztfEkKnKFZ0tRdr1GEhkLFNBNQ79QWRIS4INiqfMxoJdhwmkNQxZAr5kbh/L9mqza+EXPEsEMliXnv+9snJJRpvD5hS/DgzQO//GEhmd6QA7san/gD1VIXlpXdY8FcOwIwatIr4it5Z870e4ByjY0ufTJUVwzJbQwRQIBlf4nyCIRs83HJlA71LGIy4jAzXdwrQpt1KJ/ewQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEIKAcAN4lMPF+XjGzyYDrjABX6cFK6aPpe6dAxKMNE=;
 b=vk7JZJ1VMJdhWFG+lUvNGafmhRzGno+mrJjxYJBByxWh58hNVy3ZvJiMF8u+wlYM98k8QCPnPIsAH/5tC+mobFhtcXQu9UstmlhDTa1ZE3ZhzEP3nEJKbqec+eSzL41gjtd1a+qR4gCg0PR5emurbi+dj51V3eoQWt9IgMb0nBQ=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BY5PR10MB4179.namprd10.prod.outlook.com (2603:10b6:a03:206::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 19:32:59 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.017; Thu, 3 Oct 2024
 19:32:58 +0000
Date: Thu, 3 Oct 2024 20:32:54 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <01393fc2-7d7d-452d-8ad7-5da8b9146c51@lucifer.local>
References: <20241003170738.2870-1-spasswolf@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003170738.2870-1-spasswolf@web.de>
X-ClientProxiedBy: LO4P123CA0176.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::19) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BY5PR10MB4179:EE_
X-MS-Office365-Filtering-Correlation-Id: 25b4704e-019b-4159-7446-08dce3e2300e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1oUPadnwPO5dkbMZ0i5W6/BU0qmzlZtdMLDRnsfzFI2elVfjbdK1cOVfKX0H?=
 =?us-ascii?Q?SvX/aQ/smbP2JRdUlyKtpy1cZOs8TPCx/UtIg0eiA6I6zpFIZ4WTGKCh7HXW?=
 =?us-ascii?Q?WdmDdyqozIzQ9rNLiR1x7qYm3QpX3mMB19TTc3Fgu3HpV/8ywY/C4P6hmRfb?=
 =?us-ascii?Q?eLHABU6dFalebmu+wiCVZqNenOMBVVE+b9pMejmXZzQ6K3M7tfHWkqsgGfKo?=
 =?us-ascii?Q?cK9RrMZf/Jqnip4fEg8wROqex59SWaPmdRR4nnPG6zOTwIqkDuuhFIPgO1Ta?=
 =?us-ascii?Q?oeGBSf+pbKQpdS0xLDMCvI5r6aCrL+h3PQU0sgzWRX0sYoUMIQl25tAgNyFl?=
 =?us-ascii?Q?8/UDA4MMZV9MhNP0Wi7N5i5z9wzspdjy5wVdNUj+dr5806sqzu6EeaX2TEiZ?=
 =?us-ascii?Q?JkHCBFwFri+guPkJpfyw3ixT9YRUylk/LgZz30i3xVbPx9GfglVX08ssyBpC?=
 =?us-ascii?Q?W9wtCInxfGc/Noc9GRCw7ZHG/kPcQ1k3v/anw/bGooGHKmKSkp62AEEtRz6f?=
 =?us-ascii?Q?O8EBPL3NvG+pCspMaMIn70wlk31on9gfxSSYYPvc5SBHe85tqwBdXtj+WWFo?=
 =?us-ascii?Q?8w2mvaU9V7k8ipqDCO3Xi97eCK1rmwtjTgm03aS27ldPubGI2tLzWSqOaKil?=
 =?us-ascii?Q?T7PRIevYajUSWOzzjSFF+MgK7OB8hJD2MRkLhN/gmqMCcYGly+sbtKcBEOr1?=
 =?us-ascii?Q?EIHODbc2lkzR3bij4GReNQhWEk9vQh7Q7cLSBfmToq5mXiI4IoGnpoBWFUij?=
 =?us-ascii?Q?LgDtPcGHb3rxxChWD13fSh7710k3oLPlx0jKGPRdQVItKET7yc0IXjAtREJD?=
 =?us-ascii?Q?Rh4RD9oVdRmDmq8WQCmawp6goKzmsT+gF5r6obGy7Pggy2LaRrpyhcS+TSjB?=
 =?us-ascii?Q?/zO7DRTTB5DubJmbEldcVa2znIap18EXUbU/lUzM1tZ3e5+HT6mpLqyBKRDK?=
 =?us-ascii?Q?k4poLL6P9B6SFlbvzLxM59A1d0VgFI2A5b7YGcUiWnoeauUQOZA8DzOjTFTQ?=
 =?us-ascii?Q?YTZZP7vvLdktWuZkqYusb1sFjs2rTdGSi+mpWbF4OlrpZDDJ3YmnPrBkXbXk?=
 =?us-ascii?Q?rgNqx3dlfPQV7h9+jq5tJPlGISfKgkZeIURmlIYeqw/RyAw8itKp113bfdKb?=
 =?us-ascii?Q?qJoPo+xUMzLgJJzAZgu/1cxa+NnhAifKDk1OxRGXmyH3+lLqCxyM14/DPVAK?=
 =?us-ascii?Q?Qr6p5cUPUqwBSRunPVT+ksiyH6AiEDw+oCmSPKSNpw3I/HXyPPaQVXstWHmh?=
 =?us-ascii?Q?iRbgHWkgsXc2tZxtboKIFILs6CY1qdd+UVT3vTVhsQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xqD+oP60LNR58sA9tUPcY3z/MaSeqx6l1ViAHiht4g7bfDWLM2Q1HSFRl3jC?=
 =?us-ascii?Q?rNOKEV4FL8YYPiFk1pMLdBbUzi/VVHrO3CahUM31+BHULguGMgXeRi4ZcWxG?=
 =?us-ascii?Q?N7W5WO5HeW5eypFOnAIQiDpepEAyADIM4BgS7Nz4WvJsZw9vXlhEod12OXz8?=
 =?us-ascii?Q?ka9I+qRpgYHywRjnMuQmETO7LOwHsNiWSWSDlNHsceIQd15A+56M8giMN6aZ?=
 =?us-ascii?Q?4VBr7XU+hGmt1IcoCeB5yvCw+ks56+8FOh65dsD8UsZLEONIlR2qm0kFaqbr?=
 =?us-ascii?Q?k1ToRf0lY1Du6LzZCzsJafSWANxbMdUyDGsiNXXyzNJ77aviwKOy0VrTYhcD?=
 =?us-ascii?Q?5lQG87UOfUDKnb/uyU6ybx6PJcbfa4xqtSB0iaQsgfurqdaxe5X6cJnbFvMj?=
 =?us-ascii?Q?XlPc0QsHYScpz0H47LAMU/TcUOKgE9uCLu70xgntQSceQVGle/EJ7YO/0ZxK?=
 =?us-ascii?Q?HWJ548oJwb5+zHcSFwgx/sWD4PiVx50KdWJj5fZMP23KYiHbUE6WscMeflHN?=
 =?us-ascii?Q?2J7mvgQIO6Vc5QwhZumVzvYnE8ORURlN+5gGLN9ag5O55r2fAhuGYxLjXm6Z?=
 =?us-ascii?Q?M7k987IxxA7WodsLVbt8dL1hLW5+++/P9Ka5xMauKYt9xTndsZZfym9bDxBL?=
 =?us-ascii?Q?EcMUNM9Z3Dq+lTa4tAT8IWOaUa9gkE/fLql1uGsxGWpJbwFLTrwtgFv2rfhC?=
 =?us-ascii?Q?j9wq9SS3taj0UI0Fo2aCY7Us9AvxJUtYrYfqBPbFKNOmjhuXEW+o7yMf6siU?=
 =?us-ascii?Q?UeNLY8FUs4BdnB9UgneJhgedNWf61pOwEb7U9P1M9Sc6JONQ8z7BatmDWCDV?=
 =?us-ascii?Q?/h2o1Y96hi0KZdo9hKHGU+GpFV0BP7X444Fa3HWwhejBZRE151TAP2XFD6zT?=
 =?us-ascii?Q?y/n5QRFnmei0CVR8NYXh38Mt5XBO/hph4qtaSrXimofLWJ1neAsZtfkGJzCw?=
 =?us-ascii?Q?23B/GDf/u7lVwBg4nmpwfUBPQHv6qenA/63W0/s8LON9+xeZ+TZX64tZ0Qqc?=
 =?us-ascii?Q?OsV3v+mRMTi2vLJ++CdZO++rxOjV1gRf5dwzD/bpGi5qZo3pa+5WjVyTviHz?=
 =?us-ascii?Q?s6lBuefRTRIWLgUeh7zS2fxak/wQt3komJjYat0ax6TlPJlwzsZPnUrw92ZJ?=
 =?us-ascii?Q?V4br4HtPwnBanm5KGNgf4D4vbFI1SIZU4FDRhAB2TZr1kjMQOi/kqKUQ9/cN?=
 =?us-ascii?Q?P6ZvL69qCC4prE0kv5hpIItgSL/czjxMO8KzckyCZ9pOZu3RoJpfjBUZ+Khl?=
 =?us-ascii?Q?8ktwUTIRp76CnqJZglmFidmL89EBdNnqrt90CSvtgepUNh8L5XKkBQx5p8f9?=
 =?us-ascii?Q?1rIun5siBzruqXXfZzErD1EUjNHOtsZ5zrOzifYQZ0J1bglNb3orfgKNUOe/?=
 =?us-ascii?Q?1UlX8T7gB12kVzRHvBEvka5JhcwQMNXULULeYBrjAw/TZmgh3rEV9wkuYsbm?=
 =?us-ascii?Q?x8k/IUzWRIjecxnIGJVMlRef/ncYU2pamTBPVVLWxmEIxWQScfmJ7ZB1rLbh?=
 =?us-ascii?Q?k8fVSYMuoQGwtzFI8kJpING+cj/9yb8zkv6Spn4B7+gzUEul4mtoo8eHS4hY?=
 =?us-ascii?Q?SPoVOyDY2XChHInJTthIcKrnvsQtXYpD1ve16b+9NeOUgvnBJWUeVkPlEORP?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HBLfspnmhsQ0nW3SU5Bt4LLmilcyldBvg3Hv8dOSdE0iW2UFRuAG8yit0fl3tiSCI8umaoxxkf9bsH+SD/kaXIdCLKxDcDl72rcwQPpH1Zn9GdIERiLEw/Gh9we3shC75PfjWlWSLbcd6481q2opAA7PeLxrQ5YRiFcC7ClPjMwb4d/+bht1n60E8r3+tg49ejv8L7ENGpuCcvafFb0aHu3kxvtzDrvcUXZKykX9gSeycvj6f7EJ7pLLun7ikG+GxEKN5xCWkTx5qS91IgnTRv7h6PuL49xc3d1zSNti4MbreibB+TgvVgWsbWV9BVYLAocuzlZQVRd0OfxXzYVlgzSZkLob0mdFePIuIEUJoxMHzVbEAeXFZ8QIOZjOp34jpB5zmf7wkmIxZSnERQAWTN0uHLd6n4pTW2BB1DJVjD0vrlCmzAeW4C6Byc6xyBSRbloFIyUk+qqJTBBYNmjshIvTOtkKd1BeXXHagBbVeHhCD1pzDvZjMv2StPEjNq9hdKIuePuc8kt44OLprDUoWXVpfN/DBDyHyOqeUkM2Y2VCzSrdvhxair4nyqfQ5VJr9Z6xG8k62SYZqGjpy1W+Dzcv/KBbd/mDxxCbE2brKCA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b4704e-019b-4159-7446-08dce3e2300e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 19:32:58.9141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRYz8mM4UC+QqTZFIk3m1qjYLTIQbKF0xA7Wjn/+CDlIcvTE4zc33uXEObwSbUEnDDDUwibzyCaPES1kS8uW7TZ+y71tbTOrXvKmJshFkok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_17,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=564
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410030137
X-Proofpoint-GUID: qyA1CCyiGXfgRKMnVayWvhIFtAcVwIdG
X-Proofpoint-ORIG-GUID: qyA1CCyiGXfgRKMnVayWvhIFtAcVwIdG

Sorry to ask for a favour again, but would it be possible to run the exact
same patch with the cmdline options 'nokaslr no_hash_pointers' set? Just to
make sure hashed pointers aren't causing some unexpected collisions.

Thanks!

