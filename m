Return-Path: <linux-kernel+bounces-325814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D4F975E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 03:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1635D1F23438
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 01:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503FC250EC;
	Thu, 12 Sep 2024 01:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U2EAH8bz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OYPK5ISi"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF335684;
	Thu, 12 Sep 2024 01:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726104774; cv=fail; b=ay/hXOTtHSDmNrClxdkoObyBk2dUFdBOSMbaquiqDVaQPFnf9KhV9y+C9RUhqhXequSWsrQ9umIAVAp6m38+X86zB6LurlyGYJDWoExXWnqTU4OfmnYWIVun//LLHvYpF/c/kKMLwu8eRhxOBZBwmh2aW7oxOHHSaPS/l4ElV4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726104774; c=relaxed/simple;
	bh=YHwHy0k7M+RrwXkAA6jpTM+41P91vzR/kFgGdwz64ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nmtPvjs9PkJfs06PIB/up5iQ2LRFnuJFAlPlxUrtofS23K1pB74TwlgyS/kyqeEM1Tm3R08H7tNOTk+U0Nao/xhFHW4/qP6dnydEdFzUflknI7qAH+6VB4GB2dcUoHoPjFoGmMmSx0TUdYd5qpi/1Vg3Lz3IXMOen95ZX5pj7P8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U2EAH8bz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OYPK5ISi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BMfWOF024030;
	Thu, 12 Sep 2024 01:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=nCooQYo3ycTsjcY3JgAdfqhOqsRQCjyTsyFsN1XMzpc=; b=
	U2EAH8bz9vtE4CzIIXXjtobbzTtAtGeHKGIGyhRNyOb56SD22AOIRUcx6IlV7FqV
	gRGUjZ+J938sKtXRMexl4eNGnXeeWKPPFb3x3ESnIQHgg6jfUQrbIfkI8Xkk8FMC
	Fi0j8PjH+gLryokWs4Wys2zYcMARdJgXYVbki/Z9OYU/TEZcgf6zKrKMIxvlAIOh
	YRZlZnHn6OeqJsgWS1RUQ5GRNm2eHGM42PqXwGdjYOxmwzE3BZjbqkdsH9ih9UkL
	jBVRfgpibdtVkqhp8P75oYgiw33W/C1edE+3ujiyjkstKyqzvAHRYwdj7lbdiTnr
	55v7w8vnNAXTT0uySVb9ZQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gdm2shu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 01:32:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48C03QRs031583;
	Thu, 12 Sep 2024 01:32:34 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9b5gwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 01:32:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QoRxSYjn4NyxpyFn9JHQu/GS71q4c69UWQRYranoMXdZbCO5iHv7qhVh3jEbO4jxrT6rWBxekeiQ4PvjKDfsOJxn/gJHvdb5E0DmJpfyp411FbZAD5NqG4GmVweDU/DfDbxVMcBlp5eehYnhZmOUtMb8w92h4XCxiBLdW+AeIyNzNELfoVKKnNgOiGzxkr53hqYDFE+fn8Ye0lp/pd+kSNn9JTNzGczL/4YUddjAHEkv6cGkh81KuNsgrmWHVixnVYWk0mrbRzaD5zCPZGFz31QPI44KTepc2jxuQygv32DZrtFc/JXQVj+W8QLm++8zgvS7fkieJcv3A86tBS/9MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCooQYo3ycTsjcY3JgAdfqhOqsRQCjyTsyFsN1XMzpc=;
 b=e/y0YkeoxV5MmdU7jNWORMls/+4MYgTQEwypwVml+VQAUq2WcVPxD7Dn5jnRARZHIk/orG5dWs8E7Ysiv6v10fk01VkdP1IqfVW1v1YKfekSguJDmevlfyoGWW7xuP0tPyPvMF1GjojC5BxLrPS/PLsq4X80HJkStkoRGt3KazOdO2RxOl7s2uDj2jMqSgWh6Hd3qJMwzeHd/pQ6PSOGZ5h4QNxaP8VB+oAJqKMoZYFkrlGoHJNv6n6c6ZeM027lTvUlpJmAGBpO+wKLRqq5Z2E+GhWUINA5rNr84ZXZ7KgSJP0N/sGg6ogb+Hjj0hsE7AhJrz67GbAYxp9tcskkBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCooQYo3ycTsjcY3JgAdfqhOqsRQCjyTsyFsN1XMzpc=;
 b=OYPK5ISiE0mteby7kOcErKfWN9a94ucxv3DuU9L73yLjbKvM7xwEfSyKhg0UiNFtFYzXdlJMNN9XM16WqBO4b6wXuuuRBlnEhZ4cbaZoXludmmfa690DCbzouKPm41rlXSTJmL9aKAdfR7UO5V/vDKjQoiDlvq66VkP0IAF224U=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CO6PR10MB5570.namprd10.prod.outlook.com (2603:10b6:303:145::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Thu, 12 Sep
 2024 01:32:32 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.024; Thu, 12 Sep 2024
 01:32:32 +0000
Date: Wed, 11 Sep 2024 21:32:29 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Helge Deller <deller@gmx.de>
Cc: Yang Shi <shy828301@gmail.com>, Helge Deller <deller@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH] [RFC] mm: mmap: Allow mmap(MAP_STACK) to map growable
 stack
Message-ID: <x2d4kyyeclp5fgeug2l3bjalp773ozgkl5vr5o7dpqcbopampg@5a3x2cr456qp>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Helge Deller <deller@gmx.de>, Yang Shi <shy828301@gmail.com>, Helge Deller <deller@kernel.org>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-parisc@vger.kernel.org
References: <ZuHtb43Ar21ZptNz@p100>
 <focr7orndhsr7vhownfdhrpctwztloz54bfbg2wnd4xmqtcymu@26pn5wteugl6>
 <CAHbLzkqhc2yT=rh6ZkjaRJ8RF_NrZM6bXd-nau6jJjbow8vogw@mail.gmail.com>
 <tvllphck5fky6zqhkpcomjj5zuncgligdqapwkv5qwqamtjfc7@3geizoueze4d>
 <95c4efe9-e92a-46fe-bf41-9141e125332d@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <95c4efe9-e92a-46fe-bf41-9141e125332d@gmx.de>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::14) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CO6PR10MB5570:EE_
X-MS-Office365-Filtering-Correlation-Id: 7483ec85-05a7-48c8-32cf-08dcd2cac5a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ak9FYUdOejhnWXRFS3lOY05scHVMYktXdTVyVCtYUmZURERScGZLcVoxdTd6?=
 =?utf-8?B?Z3daa1BBYitZTmFHbW8vZWFlUlNpckd6T3RCeS9MUktTbGFrSUFVbERLNzNO?=
 =?utf-8?B?eUtXNUdFUjFBTmJJcmpxZEFYekFDL1lTMVYvRnE5VEpWaC95RWxjTmhjYmpt?=
 =?utf-8?B?eDd6MkNsM3pQaldmZnl6MU1sUVN4eUwyaTJtOUhCa0oyTXNqVDdiVXpKVkp1?=
 =?utf-8?B?WDRZZmU4SXRZdDE2dGJqbmxOR3RkZHJvbzNGYkRNYy9IdFZ4SFBWR3ZZNG9v?=
 =?utf-8?B?RWVJT2FxenY2VWpsOENaR25oRWE1ZHlnN1gyZFFXZ1BRazMxV1FQZ2dVMmtq?=
 =?utf-8?B?WWpSQ24yWkkxYWtrbjY5NTZPU2R1OThhWnl6WnJjV1hEd1BYOFVEUW5MdHUr?=
 =?utf-8?B?bzd3TkZaUVV5NzV0bUM0M3NVUm9aenFCMHpPTDdrWE9EQlpHZWVJR1FubklU?=
 =?utf-8?B?ZkVveXBobUV4SS9FVmtpMlg4OHlvMjEwYkQrdk40MS9NWkRyQ3dXRDgvSEg2?=
 =?utf-8?B?L2VKNHh1Y1NtbUNueVVhZnYzcW9mTDlZdjdMWTZaVVZaY2haTllCdDEwcGFo?=
 =?utf-8?B?QWh4cWxQdHpHM2lXdHZTbU5mMWZWakRpTDU0QzMyMmFEUEhQSk5PNXU2dE1G?=
 =?utf-8?B?RWdPWS96bC9RMURvYStiMUFBbzJIaHRTbmRsblU1OEVhK2lBSlhYM0g3bzVt?=
 =?utf-8?B?NGF6UjdFSjd1MUlHVFg5Ylh2dHhLd0JzMHBFeEdEVGtPK3ZDMTlTeFkrUWg5?=
 =?utf-8?B?bXF1b0tMRmxPcWJvblBIOHIvR1RlWUw5NlZma2pGZzdDSmNHUXViTkpBNUNh?=
 =?utf-8?B?U1pJRkY3MG55L0pCNHpYbHM5OW1MOUJCY0JMbUxYbXdGSzJ4YlN5eklXSSs1?=
 =?utf-8?B?TnZ6NXlhbGdUdGtyeWliRnRadmV5VUFpbEFsa0xWMFRkejdBaHJBZmVFV2Qw?=
 =?utf-8?B?Z2RnK0x4THNoL0wyNjN4NEhnSk9FVm1EVHEvbzBHcS8rY2xMRjNXSGxoVE0w?=
 =?utf-8?B?c3JjclFlVlZOSm1CSXdMc0RQaVZRL2plNVdVSHdPWWxLWkNXMDUwNUFDVEtF?=
 =?utf-8?B?cUdxcXdvVE5qRnhJdWFrNFY2NzVRTlhqdjNIT0ZpY2V6VE5palU3UzJLcUFD?=
 =?utf-8?B?aEpvVzlCTWNvWElMOUcxZTJXdVcwYzhYUHhzd0dIRWZUbVNQN00wSDczY2Iv?=
 =?utf-8?B?blR0S0ovYnFnWXp0QTEyVVdZaHgzYktBSlF3UG5iWm5wdXM2cHlOODRoeWlW?=
 =?utf-8?B?bk5xeWw0R0J1dElQYm5GeHRRK1lJSGhrZlptQ3lYWlJlV25aVmh3K3NqL01E?=
 =?utf-8?B?eS9KTkZhMjhJRDRZY1g0aWZaTzhONjdyMHhTUWFIL0hyTmtTSmFWYkhSR2FW?=
 =?utf-8?B?ZEhrYk9HWVJEVHFpeGNkMks0dXJpcWNNbGhpVFZ1RUQ2WHhYUXNyTkZnU1Ru?=
 =?utf-8?B?MFZVUm5Ndm9DWW00UE1JVE5nNHpqN2Y0TmVjNnBSYXF0VmZkWjlDVjFQR0cz?=
 =?utf-8?B?WVB2Ly95UTlJTmg4RERGNjlPS3p3YUxjOUNBMVNuaW5wSE4yWmp1UzFxRS9E?=
 =?utf-8?B?YzlUQWZQb05MNEhwdGZTc3VNR2owbzNlcVA2dXN6bkdGZGpRbHU3MXloY2FZ?=
 =?utf-8?B?NDJnRGtmT0hWRkVaZVhhRkNpRjNqQlFZbUdZc0RScWJxS243dGduK1RBbGFY?=
 =?utf-8?B?bEh1MEtNNEk2SFo0bjkxRi9hOU5UTkIzbEVJU1Z0NVBrUXdxeTNyM2VWUUIz?=
 =?utf-8?B?TXVPQlBuVHMyK0J3RHlldkxxMFVVb0JwQm5KOEtOWDhld3FVMzhQVFlwOTVj?=
 =?utf-8?B?VHFQRkNUNzFSaElqV3ZaUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2MrWDZhWk9XU3BxdUVVMThDR1NOYnB6aFZwY043Q080dm0vQlpaSjFocGdK?=
 =?utf-8?B?WkE4NW0rMktaM09yQmdONjV1Rngwakd6R1ozZHpaUVlkdFBhOTl1T1V4OG5F?=
 =?utf-8?B?UjA0WUdvY3lGdEsycUxxL1oxZjQrNUw2dnFteEJsbGxJUVVKV2sydDkvU01O?=
 =?utf-8?B?NFdVYjI3ZHJBYzBhQ2o5SXlhdW5JcHkxZDNKNCsxRStFNE5uQjNMWXJTR2FT?=
 =?utf-8?B?NFoyWnpUaTRSVEdYaFNxYzRFVnc4NnpRbm16c2hNYlVoK1pOak10K1lWU3FC?=
 =?utf-8?B?WE1LNzNndDlKUFF4QmJJeDVrbTNQcDRBN09HZHhVYWRGOEg1c2lJalNTc2lT?=
 =?utf-8?B?b3ViSU5aY3FqTEk4TUZwUkFrN2pjS05iL2tqdzVpSGRnU1RFQkMvSEFkQ3Ez?=
 =?utf-8?B?eGE1OXRkV3I2N2lTN3NpSUhBNmJaS0RrYllQcWJrS2E2NHZZZHV5aUVnK20r?=
 =?utf-8?B?MHZxeDFXUVNBY1kra0MrdFFMclhXZnlrMWdpOEhZTFErdm83Ni9wSDA4MXJC?=
 =?utf-8?B?U2ZWTEIybG9nQnJVdm5zaG40VkFYdEpBa1Z3YW1KZERIcjUyZDc5MlpWOGtT?=
 =?utf-8?B?MysrRDZQWmcvRGh0bitGTWU4U2F1S3lVTmZzeXdOMHoyQ0VUVWRDVzFXQzhj?=
 =?utf-8?B?MFBYL3cra2JQc1ZvbkpqNy9LNlV3YU5tSW5GN1NVY1hlYUFoN1VDTFc5blEv?=
 =?utf-8?B?ODFtZTJRTktOUFFPZm5EU2tsY0NkN2hZMHp5KzhoZ1UzQ0VFOGkwYm5mazVw?=
 =?utf-8?B?QW5xTmJNZTNkNjd3ZERuK3JHVGd3NXNYcHQ1L0VUUnRmRE5QZ0ZlSUZKWllL?=
 =?utf-8?B?bWlvNDFPUXQxYndHQkg1ZGlENW1wOWlMZFhhZGZYM0tiaXE3TS84Nmwvc1hH?=
 =?utf-8?B?aUdKeVU5NHdjeXdNUUh0TE9tR3JCLzVzS1g4T29BTGttcUpuL1J1TXhlNjFW?=
 =?utf-8?B?L2lJNDgwVXRPL2J1Z3YwaE1VMHN5MTFoUXlYTXZoMit6bGR5VGlpQi8rWElu?=
 =?utf-8?B?bG9LQ2R4YTB3b3ArTmJsc09jWXlxVytDZm1aVklhdlZJV2pKdWt0ZUxnNEVI?=
 =?utf-8?B?eEt5S21rZzd1b2p2VVBleXhEazEwMlRIb0xJbkhrNG8rbFIzSGpUSDA5S0Fj?=
 =?utf-8?B?QkRKV2FNUlNuem42TlpOMU52cFpiblA1Nk1OOXpJTklCYzJCL24zTUVTM3h3?=
 =?utf-8?B?ZHVramZSY0k4MDJwSFNLd1lOY20yWHFIbmhvY0xpTGdlRW5pdExUWTd0N3l1?=
 =?utf-8?B?WStuMHpkSitGd3poclM0VHFOYkszMEt2RGxTNXd6WlpnQWVWZGxLb3FhcEFX?=
 =?utf-8?B?MnRoQ1pDNE0wWWM2Zm1jR2tKaGVaUkU2eTVMRDN6bFYwTTRqZG9UUDJQOEVW?=
 =?utf-8?B?cFZDNjNEbG5pZlpSckl4QVJmQjNQLy9iZStJbGI4UlJtZGxCU1dDU0wyMGdY?=
 =?utf-8?B?Zm5iWk1qWWpzZnZHSldvazlQR0piRHZNcTl3MmN2UGxSbUxLK2lyWTNFWVll?=
 =?utf-8?B?ajlvaHBBbDZSY1pwd1JyUE5tenpBb01IeXl2VXRGY3hRNER1c3YvMlBLbk5z?=
 =?utf-8?B?Qnc2djVmUTZzbG43dUtuNFZQbUk4TkQwK2lRMUpmclo3NDlyYWZNbE5iRjM5?=
 =?utf-8?B?SkEralVteXdyTFVsTHlGS1N4ZzRBVHpjZWV6U3dSZWhyME4rcmw0WnFLT3J5?=
 =?utf-8?B?YjQ2YVdxcFJUNE1sVXJyMStNTlhTVHdWWURJUFBEVzBWd2lDM2dLRWtrOGpZ?=
 =?utf-8?B?Z3ZiL2FIV2tlL1BBZUdyVzBSREtxaTZLcFRTWnFLRUt3blRMOEc3ZXg0QmZi?=
 =?utf-8?B?a3lNeHBudFc0WnlIcW1yTVJ3NCs4TEt1REFhancxNkZQS3VHRGlnQjJsZjZZ?=
 =?utf-8?B?eElzc0FETkptREN5WUU0dFpRYTdaR2lIbm94b2w2Q0tKWTNIV08yR3dHSVhj?=
 =?utf-8?B?aGVmNTExTVZNKzZMT3NyT2JVczFDV1VPL0dObE1mMEJsRFJpMUdTVVEzYkVL?=
 =?utf-8?B?MUhMVUo1RitVM0t0QlpaMTM3UWg0akJ2NjNIcTM3YlgyQzVFYTdRSHE3cW9Q?=
 =?utf-8?B?VzI5dVM4bTcwSCtQRVdQNUxVWVNUZ0p5VWRrelNNeHBQQzRDQmU3UzI1Wkdn?=
 =?utf-8?Q?DK28pIdvn8SxSF/CqcvysrR72?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ADtpAqeqJE+xAFvKWkCviKFn7HPs/T5vr+cOVW9rs6EI9QjXepT9kSsES9VRHQxtA56Giv6VBqhjHN82V6kx9b+dheyRNmg9ivJrmYj4n9At8zCd7SOPlJ3ihMnmwlCur2X3smsa9W7aMSX3zunaqG54W0ptSQlaGppHLsWt4m9pbOU8dBZRkXzAu228ryFKUe+XUVR3LMFFK249pe8N21zJhHfU9C2fD3F3nnGTRSAA3LzPTlouwUFPs2LH0y4iaeOIXdvbRmXltHi5u3WpT38E69ER6Tn8H+8LyNDo51h/YWhuRVE6K0VH7XbeuYoA+6v5h3u8VO7j4vtmcCWaVPMRrtL6WIXnneEU2UdNereezGtvpA6ISj/+XGTMhA/6eFhy9OebDtDlWYZdBTGs+aKOOe7IJhn/OiYozItuvxkiZoNuMsnLSG8WegjJAboo/dLZeh3y76N84hz5bhaCyxqImq+CqetGF1g6llRaOCSCDmMNpQmvr74OOs2v5wkV/62Vl2c0S/T+X8Vv/RzvL28m5WvOhLJfE0/fsWOCe61OVeabLZdyziq5M0q8oxJhidCZPm7FjKB3o2J8itmBjqntI/2PCYNA2Z4Y9JRI6OA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7483ec85-05a7-48c8-32cf-08dcd2cac5a5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 01:32:32.2232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+ry+9RFdnhErLzrUapSl9v24bVE5ULI6uKE9xlKqSTd0AO57V00xCYwio9OXZwGX6ycGBmYmVFIhzp72152rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5570
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-11_02,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=939 bulkscore=0
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409120010
X-Proofpoint-GUID: VJ6uN0S_6dlRS_MxddAVb31I9npATgNe
X-Proofpoint-ORIG-GUID: VJ6uN0S_6dlRS_MxddAVb31I9npATgNe

* Helge Deller <deller@gmx.de> [240911 20:51]:
> On 9/12/24 01:05, Liam R. Howlett wrote:
> > * Yang Shi <shy828301@gmail.com> [240911 18:16]:
> > > On Wed, Sep 11, 2024 at 12:49=E2=80=AFPM Liam R. Howlett
> > > <Liam.Howlett@oracle.com> wrote:
> > > >=20
> > > > * Helge Deller <deller@kernel.org> [240911 15:20]:
> > > > > This is a RFC to change the behaviour of mmap(MAP_STACK) to be
> > > > > sufficient to map memory for usage as stack on all architectures.
> > > > > Currently MAP_STACK is a no-op on Linux, and instead MAP_GROWSDOW=
N
> > > > > has to be used.
> > > > > To clarify, here is the relevant info from the mmap() man page:
> > > > >=20
> > > > > MAP_GROWSDOWN
> > > > >     This flag is used for stacks. It indicates to the kernel virt=
ual
> > > > >     memory system that the mapping should extend downward in memo=
ry.  The
> > > > >     return address is one page lower than the memory area that is
> > > > >     actually created in the process's virtual address space.  Tou=
ching an
> > > > >     address in the "guard" page below the mapping will cause the =
mapping
> > > > >     to grow by a page. This growth can be repeated until the mapp=
ing
> > > > >     grows to within a page of the high end of the next lower mapp=
ing,
> > > > >     at which point touching the "guard" page will result in a SIG=
SEGV
> > > > >     signal.
> > > > >=20
> > > > > MAP_STACK (since Linux 2.6.27)
> > > > >     Allocate the mapping at an address suitable for a process or =
thread
> > > > >     stack.
> > > > >=20
> > > > >     This flag is currently a no-op on Linux. However, by employin=
g this
> > > > >     flag, applications can ensure that they transparently obtain =
support
> > > > >     if the flag is implemented in the future. Thus, it is used in=
 the
> > > > >     glibc threading implementation to allow for the fact that
> > > > >     some architectures may (later) require special treatment for
> > > > >     stack allocations. A further reason to employ this flag is
> > > > >     portability: MAP_STACK exists (and has an effect) on some
> > > > >     other systems (e.g., some of the BSDs).
> > > > >=20
> > > > > The reason to suggest this change is, that on the parisc architec=
ture the
> > > > > stack grows upwards. As such, using solely the MAP_GROWSDOWN flag=
 will not
> > > > > work. Note that there exists no MAP_GROWSUP flag.
> > > > > By changing the behaviour of MAP_STACK to mark the memory area wi=
th the
> > > > > VM_STACK bit (which is VM_GROWSUP or VM_GROWSDOWN depending on th=
e
> > > > > architecture) the MAP_STACK flag does exactly what people would e=
xpect on
> > > > > all platforms.
> > > > >=20
> > > > > This change should have no negative side-effect, as all code whic=
h
> > > > > used mmap(MAP_GROWSDOWN | MAP_STACK) still work as before.
> > > > >=20
> > > > > Signed-off-by: Helge Deller <deller@gmx.de>
> > > > >=20
> > > > > diff --git a/include/linux/mman.h b/include/linux/mman.h
> > > > > index bcb201ab7a41..66bc72a0cb19 100644
> > > > > --- a/include/linux/mman.h
> > > > > +++ b/include/linux/mman.h
> > > > > @@ -156,6 +156,7 @@ calc_vm_flag_bits(unsigned long flags)
> > > > >        return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN =
) |
> > > > >               _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    =
) |
> > > > >               _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC      =
) |
> > > > > +            _calc_vm_trans(flags, MAP_STACK,      VM_STACK     )=
 |
> > > >=20
> > > > Right now MAP_STACK can be used to set VM_NOHUGEPAGE, but this will
> > > > change the user interface to create a vma that will grow.  I'm not
> > > > entirely sure this is okay?
> > >=20
> > > AFAICT, I don't see this is a problem. Currently huge page also skips
> > > the VMAs with VM_GROWS* flags set. See vma_is_temporary_stack().
> > > __thp_vma_allowable_orders() returns 0 if the vma is a temporary
> > > stack.
> >=20
> > If someone is using MAP_STACK to avoid having a huge page, they will
> > also get a mapping that grows - which is different than what happens
> > today.
> >=20
> > I'm not saying that's right, but someone could be abusing the existing
> > flag and this will change the behaviour.
>=20
> Wouldn't a plain mmap() followed by madvise(MADV_NOHUGEPAGE) do exactly t=
hat?
> Why abusing MAP_STACK for that?

I can think of two answers:
1. An error that has worked without issues so far
2. One less system call

I'm not saying this really is a blocker, but the change is not without
risk as it does change behaviour the user could see.

Interestingly enough, the man page is incorrect as it is written because
the flag is not strictly a no-op; it ensures no huge pages.  So the
feature of applying VM_NOHUGEPAGE with the use of MAP_STACK is not
documented today.

What happens to call that use the mmap(MAP_GROWSDOWN | MAP_STACK) on
parisc today?  How does this change with your VM_STACK change?  Wouldn't
this result in failed mappings?  VM_GROWSDOWN | VM_GROWSUP would fail in
do_mmap(), and these would be set if you map MAP_STACK to VM_STACK which
is defined as VM_GROWSUP?

Thanks,
Liam

