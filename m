Return-Path: <linux-kernel+bounces-528622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA49A419EC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B9B316DFDD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7F924FC1F;
	Mon, 24 Feb 2025 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TiFOlhvb";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="DAZDmr+w"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32E824FBE8
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391038; cv=fail; b=kmTKZD1dWyhYIhg7CY0pauww093+R3X1N1cCl3hf30KFVCPG7lkXGnNTUznTI4TIcjpESM3HmbSzC8QVjddoGZQWuheXKe5FMuVPDDxmbOAw61a3ekXHuOdGtdLHCISpEZjDSSO9JEeMrL8+b4hw36+tyTUS4hh/Die3GBiAbhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391038; c=relaxed/simple;
	bh=jTCN+sgLAUOJv1vGvL9iEFX4kjaa2+kgQDLS+xbZ9AE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=agihT3zqS/pkdN7vIBtFPOVWgDJy1cloIaygJOGNJ450TvlWkBuaMPJbwbowf3nrdTdqAkzLkFKOJujMnLDkmF06kNkOiv7KQ9uzmjQO7eJBqGsEFgottFqJ/9ynEbo42NlfFOglCpF4oLEcnwXUx5TKguMETJhW5dGQdDPhQik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=TiFOlhvb; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=DAZDmr+w; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b6de3caaf29511ef8eb9c36241bbb6fb-20250224
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=jTCN+sgLAUOJv1vGvL9iEFX4kjaa2+kgQDLS+xbZ9AE=;
	b=TiFOlhvbBYtNiSKSzbjQDn8w9ZhlRo+Yq/vf4bEK3i3MpNTtSt4Zn/mvoZNSzbOKNWdGopfSj/v09GcEMP7rFkwksEPAs+ZtMT+RyC/C/L3RCn9iLqXFSv1ZvlEwi3axin4YbH2jj1tV0g98m4YK7GgK/fsX1uTJmWAeqLl/0P0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:3a378819-0509-49db-8f40-0d7b0bb283a1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:85a281b5-a2a1-4ef3-9ef9-e116773da0a7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|51,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b6de3caaf29511ef8eb9c36241bbb6fb-20250224
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 26949880; Mon, 24 Feb 2025 17:57:10 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 24 Feb 2025 17:57:09 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Mon, 24 Feb 2025 17:57:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2MAA8GMRi/9HYlqxW9+r4qkDMLY4+VvkMx5IFjHRoKUMACR1qk+qskCOO8zXao+75ugJEaOBmD91Gf6iP9P9HP5l1xwIT1dhMvjDZ8e9Rhkn4VlHyHJTkBiKcvBh95iJrCGZC3mGOeyd/kG7vXcv6umnxejQiNLdE1DSrLWR6tN8M/sTMb6iOuoDb0NrXpvLpT5Ocxa5WGx7aV2IoNqcpIha1sXQNyAn66D++uoRa9gzCs/DUT3h+mHCB3iTmfe3rEReSn5gIl4CR2h04ZQ+dXbURhIfa2KF2qPntyBqthGIIyGLeL3yILimAlVUE3XZ+l5RPvON9NUdq3yWLKSaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTCN+sgLAUOJv1vGvL9iEFX4kjaa2+kgQDLS+xbZ9AE=;
 b=g4RyzZwjBHZbCdMoy0MjG+8oNcHoqh81qGzaG9oy649dFiw0ZmaOYROEOmDillsCVhQFOXtkjNXx/T+Lj5SY4Hv1qJdDOXGk2VTbN0cNfSnuL8JiSLJ4iUEFwAeHI0yJ9bmwG+PtcHMVRlHgDWpLrKhepCe+Cv1ibIYXvE1awx3LU2qKOY5gBCj1k2PnBHFX7lT+wVN2hed1wOc/U/6ruWHny7lJnOdU8nSi6AqWzwrq32b6hY6pW/AVthxO4PTXtCjmFds42y471UbXEwvtHxO7mVfqrZbur4EEtc5L7xsO66oVshDgiw9NIwHrIkwstIGFE2F3jPRZKEftI3DfqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTCN+sgLAUOJv1vGvL9iEFX4kjaa2+kgQDLS+xbZ9AE=;
 b=DAZDmr+wqMavoJobPsKUijrSUeIMGtwYhXSNZAF/MvkFctQBbZdokgD+ZlFabLF0WC5S4KsQaCEhbYRJRB3YQNT5YyTQdzDbIT7+1ufW5BHYWQ0qM04UtFn4LkBdSCvVPzM1WpunXg0sMxmCTAjocHRNZ8ZJqud2IMaWoTJN0iM=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB6423.apcprd03.prod.outlook.com (2603:1096:400:1cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 09:57:07 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%3]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 09:57:06 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>
CC: "treapking@chromium.org" <treapking@chromium.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?=
	<yongqiang.niu@mediatek.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	=?utf-8?B?WGF2aWVyIENoYW5nICjlvLXnjbvmlocp?= <Xavier.Chang@mediatek.com>,
	=?utf-8?B?U2lyaXVzIFdhbmcgKOeOi+eak+aYsSk=?= <Sirius.Wang@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "wenst@chromium.org" <wenst@chromium.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?WGlhbmRvbmcgV2FuZyAo546L5YWI5YasKQ==?= <Xiandong.Wang@mediatek.com>
Subject: Re: [PATCH] mailbox: mtk-cmdq: Refine GCE_GCTL_VALUE setting
Thread-Topic: [PATCH] mailbox: mtk-cmdq: Refine GCE_GCTL_VALUE setting
Thread-Index: AQHbhno/Q4rQwtBqAUKna3pzKMPTObNV9vmAgABA/YA=
Date: Mon, 24 Feb 2025 09:57:06 +0000
Message-ID: <16e058721ed0bc4a2ccec7d4b9c5eb35d646b2be.camel@mediatek.com>
References: <20250224050812.3537569-1-jason-jh.lin@mediatek.com>
	 <3077494e5e989db6e347bc7c681bb584ab20e593.camel@mediatek.com>
In-Reply-To: <3077494e5e989db6e347bc7c681bb584ab20e593.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB6423:EE_
x-ms-office365-filtering-correlation-id: 501387ca-2dfa-4e54-3419-08dd54b99886
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QldrcmdZZDBKblU2UnI0eEQyNkFTdmdKckU4L1J6ZGd5U2ZQU0pJNCs0eFNR?=
 =?utf-8?B?UUg5WDJJbVdmQ2F6NWhSUU1SaU1mMERLalAwLzh3b1JTa3hCYlJWVUpKMnIw?=
 =?utf-8?B?d2RvRm5SVG1UN1ZZR01UWTdqaEw3VDJ1VjRkUXFrcllHdlowNGpYcEVPL3VN?=
 =?utf-8?B?dXJPZ3FmNW9oL05DcU56UTFJbzhZZHdIM3djQ0w3Um5hYS9NcVh6N2FoUUc3?=
 =?utf-8?B?dEZQRGlIZXY2S3hBQkRNUkMzd3VVZHV4bGRJeDRIQTdRbHpxNnhZaHpOcGpD?=
 =?utf-8?B?czE5QnRBWXBTR3YwYXkxOGE1YWxrWGRxcGRkMDZHZFhFMm9JTU1HZDVRSEFj?=
 =?utf-8?B?VXU4bDZFREs1SEk3L0ZSRTd5SmdFN2VYWE0vdWw1UHpKa2xjMHlMSkZ3WjVI?=
 =?utf-8?B?OFJkR29RcDg3czVldnYrU3o5Z1lFKzNaZlJKMS9QQklMOGxBUnZwcEwwbVll?=
 =?utf-8?B?UCtoWGNXVkdjQUh4dUVsK0hSY1cxVTFSd1FDcE5SM1l5WTd5QUhUSDdyQXpO?=
 =?utf-8?B?YnJOYjNMVzlHRGlXZmVhV2JwVU4wckhnQm1MNWJuWEY5TllUVHZOdnpaZlZG?=
 =?utf-8?B?V3R4Um5OY01uNVI0VFExS1lremhuQnZDamtVdElZWTRYWnpxblEza3N0NGpz?=
 =?utf-8?B?Z1pLbUF3bXNxNkgwNTZVSjRiRUg0VEtWRllnYlV0cVhra3pKdHQybHBIUWkv?=
 =?utf-8?B?eFFXQ2FOc0FDdUhna1dsbSsyZkxVZHg2Y09DVjlnMGdxRDB2bkpRL0hFWXo4?=
 =?utf-8?B?NG4rOUp6dUpzbUQzYmlxY2xFd3ptYUxxSnpzK1JGQWN2aXBDTGdnRnlJNkdJ?=
 =?utf-8?B?UDJtdmsvOWZFODdZTEFSVzEzU0JLL3gyRjRUWXBHQWJVVUhhQkNGUVQ2RmZK?=
 =?utf-8?B?eUs3NVhENk15a05WdkRXbGFFd3pTQWE1RVZvSGNyMS9kK3F5aWdLUC80T1pC?=
 =?utf-8?B?ODBaN3J1ZlByR2RZWnh0MlNxVklERU52ZytEeTBCdVdSVXJRY1Y3bjlTWVF0?=
 =?utf-8?B?REpBbithZnpRdmtuQyt6dys1b1gxUW94R3ZsY3VuL3ZaZnVjUGMyenhBNzg2?=
 =?utf-8?B?VDUxbnJtK2Q4UFJwSkZmcFdGRmk5T2R2b08zc3VxS3lkVHhOb0VpZFpRd0lO?=
 =?utf-8?B?VEs0dlBvZUkvelEzNStiMGVwS0ZjZ0FoSHlKbDdFdklncVAwNUIrUkVnRVdF?=
 =?utf-8?B?NHJkMlYrRE9mRHNQcmNTR0hvTFhuYllBazMyQ3NkYXlkOWlqdFpaK3Iwc1FJ?=
 =?utf-8?B?VXVEbXRJSDZTb0EyM3dqOC9GRUFQWTdWRFNHa3ZGcnhKYlZlWGtRTW1scnQ1?=
 =?utf-8?B?TUx3Y3lzc0FFZmFSZEZnbmdCdGJZNHc5eEt4N0l2Y25ycFZYZ2xPbnpjQ3k2?=
 =?utf-8?B?dkxpU1BnanhiYlpKcVRHZDB0RHRQZUxkUGlOQVVYSDdqTE4xTk5WQjBEb2Za?=
 =?utf-8?B?MU5Bb2ZGMTVBRCtBNXIwcVNkbHcrUHFWTGdOcDN6ZW83d210K2kxaTd5c0xy?=
 =?utf-8?B?R3FnVVV1OGpaaHZHMHFKN1JPMWtUREd5K0VkbkxydGFlWVVlZTAxRmtJMVZR?=
 =?utf-8?B?Ync2QUNMcjlPSGdIbGx4RDc4WDIydkVPanl6NlV3eUVscXRpUFRlak1GVE9R?=
 =?utf-8?B?a3VLR2swVG9sd2NlQk9hY3JCSy9OL21FMWZHOURFcEltUUNrdDB4QVlQUkU2?=
 =?utf-8?B?SGN3RVpqb2x0VlZOdzIyd0YyaCtjNmVSWFdVdDJpWnpkYmlXKzJSTFlianpE?=
 =?utf-8?B?M1RqdkVSR0RxSmN5L01KbzR1M2dya25tcE5kTmY1STNwNnNabXdHUDNxMG56?=
 =?utf-8?B?SlZMaStCWGhVZzVTVjhPZXVBWHdPYTZ1OExaa1FyRk9ncGJMUFlzYWJEbHRB?=
 =?utf-8?B?bjFSejhBRWc3VURGZ0JpclBoYnJaVE5CZVhEYXI5ZVdKd2RJMVpla3N0cVZ5?=
 =?utf-8?Q?S2SKhlGcz1X2+P/vUu9pYGFSTd76a4pQ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzVqMTVPbk11WVhVa3AzakFJMElKQzJiakYyeHVBdVlDTTd3YzQ0SnlCVExr?=
 =?utf-8?B?NmdlZjJvSGQ0Q002MnIrb29KR0JvK2lLRDJUR1N2OHdXaUNlN2dCUDA5bGNM?=
 =?utf-8?B?M0diYmw2SEFhRXZST3ZmbVdPRVNsaEQvd2R5RFVMSVNlblpEcHhxZVhQM25L?=
 =?utf-8?B?bWpnQTRscllaMGk5Y01IbTJVSHB0dUxCT3U0Z1h4M1MzcXR3SENzRDJPdlYz?=
 =?utf-8?B?Zm5VL1VGSG1Dei9MMjZVK1NOTUlOaFY0enl0c3JkRjZhQmVKTTcweitNTHBV?=
 =?utf-8?B?NTc3NmdzcElIeHgxaG9ITFQ4NTY5ZnVWLzVFamwrWFR2bktPQVF2K0FOL1RZ?=
 =?utf-8?B?R0lzcVV2ajlzbmpudDloU3NFWmx6akRNUE5jdnNoQjZ2N1FnT3M0RW5hNlEy?=
 =?utf-8?B?MVdwNkU5M29ZaitUUkpibUNKWENrZUtpT1dQT2pjUjFLQ2c4OUVYZkZNbEF3?=
 =?utf-8?B?cUhwWWtPdmlnc1JIUGJBa0d4SVR6N3lLV3l1QjdIMzNxVDlEU1J5R1pZcys0?=
 =?utf-8?B?YVN3L0pOZzlIUHRpYzZNd1dkNTdFQzh1b21jek1QMHViQnFlb2l4QXNKNXUx?=
 =?utf-8?B?UWsrdWZEczhITlU5aEthQnhJVkpDeGwyNElKdkFNRTdLaVhYcUV6UDJsbE50?=
 =?utf-8?B?OWVyRnNvQUF4UXB5bUZRSHpZVWZVbG1vY2FxN09qQXNBS21vaG5lNzlkZXNw?=
 =?utf-8?B?aFRpclBlcTg0a0JNeEhkUFZRSCtjK212MFNZZElRaVJObm04K1pzWG9rV0xj?=
 =?utf-8?B?dk1vWnhONDRwcTkxa3UrTEZMWjdSb29mSnoyRFl6bWRQMWhDMHZBVjdMZEpO?=
 =?utf-8?B?ZFI1TjZ1Q0FKNUFaVzMwOFdXRXlMYU5OaFlKaG9hdjd0SlJ5bWFGYjlCVHFK?=
 =?utf-8?B?b00rRHNvaWxseHl5TWo2Wjd1K0hoUi8yL2ZsRjlPaHZYMXlhYTFkcjIyRE9l?=
 =?utf-8?B?VGpYbFRMaEZlVGRsMHlWZEFrSlZsUm82b29idDVVbzFsblZ0a29TU3RKS0tl?=
 =?utf-8?B?Q3BPdVNWaE9xZkovNWdveldUWHBJZ2kzaUpBZ2ZhSUlUWDl4dFBjNldQeHpv?=
 =?utf-8?B?dnljMjVLQ2Rua3QzcXFkZENEU2tqdmJSZnpSVWVjSHczOTBjd05EOEQ3ODFt?=
 =?utf-8?B?MVdpN1dIR0ZBbTBIMXNRYXhyOTdWOW9jbTB3OWh3VzFmOWswT1NTOW1Ldzdk?=
 =?utf-8?B?aVNjSFZoSGF6L09sM0lQL2hGcGVrOWl1TEtKc3VMbUJiZDNkNmk2TmE1dmdF?=
 =?utf-8?B?bFpBVm1keEFUMlRNRlY4TlF0d1B5MUVBUnNnbUl5R2IvL1FEZ09tbHl3dWpZ?=
 =?utf-8?B?SGx3Uk1XamZUWHcrcUVraVo2OG45UGRMdW1TMEtnOTJsbUlQeUNuZWJYV0Yx?=
 =?utf-8?B?MDVzckY5WFRSWEFXZ0hmQjlLYVVJQ1NBTXRRNWJ2VTFQdzZjU29KeEh2M0hV?=
 =?utf-8?B?d3pGQXNwdllWNDdnZUFXMEZKWWowcHZSZjZWaW9WYTY4a2tRWGI4NWE1c0F5?=
 =?utf-8?B?ZHBFbzB5L205NXdrOVM2WHVSaHpLclc4eHVrbE96Q29kbTVwZW5EeWIvZlh0?=
 =?utf-8?B?ekk3L1JlM3Zva0cvdnBmTjZyVGlhZjMzREc5WWFHbnpSKzF0N1kwTVFHZ05h?=
 =?utf-8?B?ci9GYUhvaVdxNXdmVTcxYm5nYmhIS0J1K0JxVUNkTkZWNndOUzVaWnpFcUFH?=
 =?utf-8?B?VTNEb0xWeVJrb1F1Ukw4Nk5LcGZSMkZwTVU5Tm5TczQ1aFhCdGQrS1VkMmJZ?=
 =?utf-8?B?OEpwbGp3NHgwV1cyTjlZbE9zL0VFUXgvODcrRHJ0b1Irbkc5dXNZeXdrQmd0?=
 =?utf-8?B?WnpJZkVUWVFXYk13OVkxOW1CREFzUlZHWXJneXVRNzB6dGd1RTVZK0dmQTNt?=
 =?utf-8?B?dWxRWFVWRWxFVEFGRW9JbkljRmozRU5PTEpJMXBhcmJjdGcwVjJSeHo1Mk1t?=
 =?utf-8?B?WFVCTDRpWm9WajlvSVFjVFdBRWs5ano1UzhneCs1VklpeWV4YnlHaWlONHE1?=
 =?utf-8?B?SmxPMEJhMzU2bnI5Ym9FRzJMZ0MvaVBrdDBrUzZRTkJTT1IvZC8wODh2ZjVh?=
 =?utf-8?B?cXF4bk93dklWcXJCQUN1cDlXVDRlRjNvL0g4ZnN0VnNoQTBEZzI3MFE4ZGU3?=
 =?utf-8?B?cUF3U3pVc0tTbHpsNTlKOFl6VkdLVU5ZWU5GQVAzU0JySkl3cXFOZTdFVUMz?=
 =?utf-8?B?d0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B5FADAE771A9D4FB856FC6ED5501CF4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 501387ca-2dfa-4e54-3419-08dd54b99886
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 09:57:06.1079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f/0MdB/9md9kC/K19zLfYKmfwDXYThJ+HHP/mRYkB9VtrstXt+jTILic89/a/nDLSSY/PWO5KLz3664dNdL+OLuJ9iuIrST4gcHQLIrwujI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6423

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIE1vbiwgMjAyNS0wMi0yNCBh
dCAwNjowNCArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3JvdGU6DQo+IE9uIE1vbiwgMjAyNS0w
Mi0yNCBhdCAxMzowMSArMDgwMCwgSmFzb24tSkggTGluIHdyb3RlOg0KPiA+IEFkZCBjbWRxX2dj
dGxfdmFsdWVfdG9nZ2xlKCkgdG8gY29uZmlndXJlIEdDRV9DVFJMX0JZX1NXIGFuZA0KPiA+IEdD
RV9ERFJfRU4NCj4gPiB0b2dldGhlciBpbiBzYW1lIHRoZSBHQ0VfR0NUTF9WQUxVRSByZWdpc3Rl
ci4NCj4gPiANCj4gPiBNb3ZlIHRoaXMgZnVuY3Rpb24gaW50byBjbWRxX3J1bnRpbWVfcmVzdW1l
KCkgYW5kDQo+ID4gY21kcV9ydW50aW1lX3N1c3BlbmQoKQ0KPiA+IHRvIGVuc3VyZSBpdCBjYW4g
YmUgY2FsbGVkIHdoZW4gdGhlIEdDRSBjbG9jayBpcyBlbmFibGVkLg0KPiANCj4gV2h5IG5lZWQg
R0NFIGNsb2NrIHRvIGJlIGVuYWJsZWQgd2hlbiB0b2dnbGUgR0NFX0dDVExfVkFMVUUgcmVnaXN0
ZXI/DQoNCkFsbCB0aGUgR0NFIHJlZ2lzdGVycyBzaG91bGQgYmUgd3JpdHRlbiBhZnRlciBHQ0Ug
Y2xvY2tzIGVuYWJsZWQuDQoNCj4gSW4gc29tZSBoYXJkd2FyZSwganVzdCBuZWVkIHBvd2VyIG9u
IHRvIGFjY2VzcyByZWdpc3Rlci4gSXQncyBub3QNCj4gbmVjZXNzYXJ5IHRvIGVuYWJsZSBjbG9j
ay4NCg0KTVQ4MTk2IEdDRSBpcyBwbGFjZWQgaW4gTU1JTkZSQSBhbmQgdXNpbmcgTU1JTkZSQV9B
TyBwb3dlciwgc28gaXQgY2FuDQpiZSB3cml0dGVuIHdpdGhvdXQgZW5hYmxpbmcgdGhlIGNsb2Nr
cy4NCg0KPiBJZiBHQ0UgbmVlZCB0byBlbmFibGUgY2xvY2sgdG8gYWNjZXNzIHJlZ2lzdGVyLCBh
ZGQgaW5mb3JtYXRpb24gaGVyZS4NCg0KT0ssIEknbGwgYWRkIHRoZSBkZXNjcmlwdGlvbiBhYm92
ZSBpbnRvIHRoZSBjb21taXQgbWVzc2FnZS4NCg0KPiANCj4gPiANCj4gPiBGaXhlczogN2FiZDAz
N2FhNTgxICgibWFpbGJveDogbXRrLWNtZHE6IGFkZCBnY2UgZGRyIGVuYWJsZSBzdXBwb3J0DQo+
ID4gZmxvdyIpDQo+ID4gU2lnbmVkLW9mZi1ieTogSmFzb24tSkggTGluIDxqYXNvbi1qaC5saW5A
bWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+IMKgZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1h
aWxib3guYyB8IDQxICsrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+ID4gLS0tLQ0KPiA+IMKg
MSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKQ0KPiA+IA0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+ID4g
Yi9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+ID4gaW5kZXggZDE4Njg2NWI4
ZGNlLi5iZTE3Njk3ZDc3ODUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tYWlsYm94L210ay1j
bWRxLW1haWxib3guYw0KPiA+ICsrKyBiL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94
LmMNCj4gPiBAQCAtOTIsMTYgKzkyLDE3IEBAIHN0cnVjdCBnY2VfcGxhdCB7DQo+ID4gwqAJdTMy
IGdjZV9udW07DQo+ID4gwqB9Ow0KPiA+IMKgDQo+ID4gLXN0YXRpYyB2b2lkIGNtZHFfc3dfZGRy
X2VuYWJsZShzdHJ1Y3QgY21kcSAqY21kcSwgYm9vbCBlbmFibGUpDQo+ID4gK3N0YXRpYyB2b2lk
IGNtZHFfZ2N0bF92YWx1ZV90b2dnbGUoc3RydWN0IGNtZHEgKmNtZHEsIGJvb2wNCj4gPiBkZHJf
ZW5hYmxlKQ0KPiA+IMKgew0KPiA+IC0JV0FSTl9PTihjbGtfYnVsa19lbmFibGUoY21kcS0+cGRh
dGEtPmdjZV9udW0sIGNtZHEtDQo+ID4gPmNsb2NrcykpOw0KPiA+ICsJdTMyIHZhbCA9IChjbWRx
LT5wZGF0YS0+Y29udHJvbF9ieV9zdykgPyBHQ0VfQ1RSTF9CWV9TVyA6DQo+ID4gMDsNCj4gDQo+
IHUzMiB2YWwgPSBjbWRxLT5wZGF0YS0+Y29udHJvbF9ieV9zdyA/IEdDRV9DVFJMX0JZX1NXIDog
MDsNCj4gDQoNCk9LLCBJJ2xsIGNoYW5nZSB0byB0aGlzLg0KDQpSZWdhcmRzLA0KSmFzb24tSkgg
TGluDQoNCg==

