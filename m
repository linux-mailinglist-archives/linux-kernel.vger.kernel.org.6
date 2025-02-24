Return-Path: <linux-kernel+bounces-528219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710C1A4150F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED0A16DDBE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 06:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F8514A630;
	Mon, 24 Feb 2025 06:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="l4TPkNcC";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="PjiMWLWx"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E086C28DB3
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 06:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740377080; cv=fail; b=hv5hkWFmtqrWY7VrqTG1Gz4U2gdZNtBQ3xfD4LY0gZokdXnU91ql5IPd8sIsVvjt2sHMq/NMay8sM1Vr6bUSRcJMcZvUw1HRybwYxWRSgGpj18+gTloeHP+qsz75KGpQgPZA0NWxe5TaHL9039/04VshJYVFIZJ7XrE4dgrZe9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740377080; c=relaxed/simple;
	bh=vexh71ZD3exBR4GGkshzQzs5BOE6GhkwCNiingGsc4I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GNB6BnG0wprfiN87ydFA8eTM+FsjDHAvC3qhRGEFcZvvJGNt43kx+8cnBE/t4nJKorGHechE8sxdinDhDUY0bGUbKvlVW5k91Pzp4fE70SdSHc45ED9cMBQouGzR9RcBLFekz70LkhlMm46YBoBNEvwAPDU/WoJ0tiwej+RFX8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=l4TPkNcC; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=PjiMWLWx; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 37f3be6cf27511ef8eb9c36241bbb6fb-20250224
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=vexh71ZD3exBR4GGkshzQzs5BOE6GhkwCNiingGsc4I=;
	b=l4TPkNcCG5/6bbNzYrfb94xGuFRgGUrSL0PPq0sqtcPIDygsDEcZ1B4bF3VLF1OVEZ+i2Xv2/VK0kS5NrJlEUS4EAef4nTuHgf/qdQu0QA9yYgcwfMBTYta/sD3vHTnqRY59+2/bHpIHbj5kR7kzOltpNoUgGnQpdck1PWFFT64=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:b0b4937c-5d49-4349-9e69-a121fd3d0b68,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:4c4c2c29-e0f8-414e-b8c3-b75c08217be8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 37f3be6cf27511ef8eb9c36241bbb6fb-20250224
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1348880135; Mon, 24 Feb 2025 14:04:33 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 24 Feb 2025 14:04:32 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Mon, 24 Feb 2025 14:04:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vf81WOnwo24/Ke2vs2T1+t/mmp7JXwA6Yz6/1lO/jyuUyUo6SLQIbLfClRnKFbDbzZ4nQXpU85JlrhlDmbq0FlMqNJ7FJtsBvrM8ghVni22TYnTHxkC3BDZufIzJOT71Y4VqhEWhHVivYCa1HgxHe+LX5DL1UJNuc87qXFoPPxarjUAx9J6SdaMC6uHejjtz8YidnINrigV6QNQxWXCr2IN4uOKgHw+cyBsXfi5dd/kmYbvdR4ruLRqC/ppFzHur9g17lYlcp+KhsVo0zCy/xcBaboC7lbxP43udzXlVepEoNvEL0qg0nkUcZlKETmBkKmlltJbxKaTbSD9WFuC/XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vexh71ZD3exBR4GGkshzQzs5BOE6GhkwCNiingGsc4I=;
 b=PKCWx61EZB463r55jeNs03HdKf5VtuZrUs9BUf5xB2tlYJpC0RXpoLoHAqUJjbB0y3hHxWM1upruiwt5fy7E9o1lA21xBjRy8xwzfFFUIH5q/JuckT76MML2cwZ0kHylwxL9KkS1JiA8jlLfKB70B2LVOz1toqFBzhgxz8jNUs7U+TM+nk+P1feUguJZHXJ8vyCDWuqqZ9llqGkWdb0W2No2PqhfMWzm2QHUpxmQ1Y+8R2aP78xm3lKWSM7MmYPqkIxn/Jy8dpitNzuVUACs4bXCu3xbMj0wH8kJn6/p7j8jIH/2PgWzgdkwZxsDfFZXNhU34H264sEHgCECi9R9Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vexh71ZD3exBR4GGkshzQzs5BOE6GhkwCNiingGsc4I=;
 b=PjiMWLWx5ffR16IyF33rSrLn9UCNd+oEz0L6nx6rjZi/6dFVkEH3Q+h3UuCmdm48Zu6/T9pjm6QDPFuYjb2AQE9yJSWrXxsGcBeHAnP5OADuZnUzlGRXBfIZGFCaJFeEFEVNYdUSZfeLZlQ1BGWYTihj2+CaVZc9MdjavDZB9Ls=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TY0PR03MB6536.apcprd03.prod.outlook.com (2603:1096:400:21c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 06:04:29 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 06:04:29 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>
CC: =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"treapking@chromium.org" <treapking@chromium.org>,
	=?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?=
	<yongqiang.niu@mediatek.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	=?utf-8?B?WGF2aWVyIENoYW5nICjlvLXnjbvmlocp?= <Xavier.Chang@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?U2lyaXVzIFdhbmcgKOeOi+eak+aYsSk=?= <Sirius.Wang@mediatek.com>,
	"wenst@chromium.org" <wenst@chromium.org>,
	=?utf-8?B?WGlhbmRvbmcgV2FuZyAo546L5YWI5YasKQ==?=
	<Xiandong.Wang@mediatek.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] mailbox: mtk-cmdq: Refine GCE_GCTL_VALUE setting
Thread-Topic: [PATCH] mailbox: mtk-cmdq: Refine GCE_GCTL_VALUE setting
Thread-Index: AQHbhnpp8hzUiENBlUmc2hoSCInXsrNV9vmA
Date: Mon, 24 Feb 2025 06:04:29 +0000
Message-ID: <3077494e5e989db6e347bc7c681bb584ab20e593.camel@mediatek.com>
References: <20250224050812.3537569-1-jason-jh.lin@mediatek.com>
In-Reply-To: <20250224050812.3537569-1-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TY0PR03MB6536:EE_
x-ms-office365-filtering-correlation-id: 8687a01a-2f19-41df-1ce1-08dd549919bd
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?a2UwZDZLL2U5UmdkTHVlSE45ZjBTbDAwT3dWeU1SU0RQdVJSQ1A2OG1odHoy?=
 =?utf-8?B?NWg3dXlSSWdLbkVxY3JHZUFQWk5JM0pnNmtEQWkzOXZkdE5ybkxHUTErZGNZ?=
 =?utf-8?B?WWpQWE9ac3hzMk8ycnh2V3FXNE01UGRzQy9XQ0NwWUFZaEt3RStxM2VWTnFL?=
 =?utf-8?B?eXc1K0hwQUhrZUZlSjRoSEt4Y3REeU04SktEb1ZLSlhWSmNrY2Z0dmpOQ21r?=
 =?utf-8?B?cFB3MFVCbHlTcjV1QkE3NVlBYVRCNTBJN3dqWlIvYTgxNHg0bDZlcks2eEht?=
 =?utf-8?B?b2plZVNxY2JBWnZJSnlWb0pPNE52dDk1dXpZRmozeUpkUUFLQTNzY1JoaXZv?=
 =?utf-8?B?Tm5TM1I4dzR4Y1FrSk43dlpxbXZVZ2xWbUtpSkZMTEhRdXZWZS8vL011SUFx?=
 =?utf-8?B?YUtJV0NncVVYeXBaZ2ttbjJONHVZVDJLVHE1ZUpoSzArU3d4N2dEUStFbDVP?=
 =?utf-8?B?bURUYlhJQjJTMzdjNmJLUmlkSVlXNWVMZWdWK0tBRFNKTitqZkZhSGw4RDR4?=
 =?utf-8?B?eVhqZXQ2aHJzTk54VXZJNmlZS0QxaFM3N0dlZEh5Y3J3WGxOZTFnU3NiczFt?=
 =?utf-8?B?aCtBTFJ5Y3EzM2Nkb3lNQzVYQVBMTTRvQ3RETFFhc3Y0S2pGM2ZxS0FlZkRS?=
 =?utf-8?B?QjdnM2Q3NWQ2aDh6aXVQOXhSV2E5U2k4a0ZBSVFvZlQzanlDaEFEaUZkY3Ba?=
 =?utf-8?B?UlF4V09JMzNiNmJISTg3TDB5WG95OU4rRFdZTGZiZGxTNUd3VWxWZmp4NlVs?=
 =?utf-8?B?NGhsL3FvUjM5K0d2RzF3UWZBOU53OUIyQkJGRjhRMUlNWWFSczRiNkVMdm92?=
 =?utf-8?B?R3FKbmdxUTJsVmZsaFlKalMzcFcvWlJUZUI0SlhwOUh1dDVnU0lTRHJ2M0xQ?=
 =?utf-8?B?R1o2ZjM1aDlBdjVmLzlhVS9CRGJoWGx4eUNyUUVnayt5OGZiMHdtMk9ac1JQ?=
 =?utf-8?B?b3B1c2V6Zmc1VTREZHBZM1k0NnNsWUdOYU9BMDZwaEFOZHZndWhseGw4T1Ew?=
 =?utf-8?B?ekthUVd4ZmVmZnFuNWRMYXBnN21OaUFlN0lSSkV3VUVxaFE0KytLNEhSM3Ny?=
 =?utf-8?B?R28vVzdGTllRcmNrRVpYZTBMeGpRaTd4WUNTMDFhUndOWS9LVjg2cllWQUpW?=
 =?utf-8?B?dGUrQldHckhzdndTRGZaVVVTYzhCQ1VqZE5lUVBXWUdpeTVIM3N2QW0zSXN5?=
 =?utf-8?B?blBUMFduQW0yb2V2aUM4ZzdSelYrWWFpdFN4cWxNa29zMXpUcnJOL3Blb0RT?=
 =?utf-8?B?SCtEajR5SFBPUGd1bFRvdGduQ3N1azlsQm1qSldXbk8wMklURk1Bck50QUI4?=
 =?utf-8?B?K3k2OEdSbU9HZEFYZFhxbXkzaEtmSEprV0lFVFpJVjhTaUR5eFpadWVVQmh3?=
 =?utf-8?B?OUxDT21BQTBNTEdRckJwWk5ZWS8xd0ZlMW1UTkpwYmRuWW5sbktzSWNwS21J?=
 =?utf-8?B?SmN5MXNwc3lESWhhVWg3cXVxd0t4VTYrTDFyWWxzbUU2bDY5Mkh2U2NmeTBK?=
 =?utf-8?B?eDN3eWF0QSs5UmFuWStYMWhOcjlMcXhoT09YZUdscUsrSmtkemhqd2NsN1Jo?=
 =?utf-8?B?VHhkdGRRV095cllTYUlOM3EyeExMZEh0RytvU1NGSGVnaEdCZENLMjVUdjJO?=
 =?utf-8?B?cHlPWFhRampoWVdPOUp6NnpYQitZZ2VHalI1Zks1RStydFFvZFp5a2NjdElY?=
 =?utf-8?B?K1g3Wkh2WGtVRlJGMnVkUDFUWHZtMnY4YWRaVnpSTGZtSGtINjFaMktxaldr?=
 =?utf-8?B?ZjhQSkQ1Mm11Y0VCU3Z1UlFiNTNCajlCZkJZSUUreVl3OUNneWUrWmR2ZVBH?=
 =?utf-8?B?dHFLc0t1UmxHTDM1N0ZReUUwNkcwU1NWcXF2QSszcU1ZRUxxbkE3anEzWkcx?=
 =?utf-8?B?SXlucWZXbzZLNGlyY3pscmF2RThpdy9BclUzemFvUHMyNlRnZGRNSXV6c3A3?=
 =?utf-8?Q?v+G+laBBmZjm00L/hfjA1DbWZykeZ/7U?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2g1QXRNdWY2bE0vR0dLTmVLS1RoaGh6enlOYVg1QnpyVzF6Mkw4VXZzWW9t?=
 =?utf-8?B?SHloQWNTSHlZK25hb0VLR0krWUdpWis2RDZUdWhwaW9OczZiMFJ1RDlMRUhF?=
 =?utf-8?B?K05iaTV2dVVRc0s1SllzcGMyaUVVd2NZRUF2cFVYb0YvTXlVOXNFNE5kSk9r?=
 =?utf-8?B?MHp4ZWs2Ukw3dVZ0NlJtV0c4Z041SzVzdEZhR3ZLK3pyNTF1T0dlWWoybmpC?=
 =?utf-8?B?eVExNzlmK1FQYkJQVW5WSzBUeVFWZTJsaHljZWs4OFJaVy9VOXUzakVYaTdW?=
 =?utf-8?B?UUxHNFIvU2xKNWxGWlFqYnZCaS9hcHVCR0daVVZVOEtEUkJwWUNVd0xJcEh4?=
 =?utf-8?B?UlNFK2RwWUdIK0VrZ09wRGVzMVNNLy9EUHU2Sk1JbzF3UVQxNmlXZ2ZVL1pn?=
 =?utf-8?B?bjdEWjhjMWhWUUFYL2t5ajV6YnZWV0pxUnpCRjliUkh5MlI3Z2xzS3ZMaDF0?=
 =?utf-8?B?VFZNVUFYOExoM0NjcWpWK2ZKR3VWWG4rRE00a0JFUDM5VzhIVmRnU2YzS3ZJ?=
 =?utf-8?B?RmFFcE90dGlxTmh6NEowQjE2MXVZZThGQVJoSzN0ZmFsbGpmemMvbU1tVnhO?=
 =?utf-8?B?SExNK1dJWVVqd0IyaFkvVFlBUnoxSjEwaVRZRjFzdWN3cXpMRTMwdVF4RFp1?=
 =?utf-8?B?TXpIbnhTMkF2Sm1Xemo3ZFNtVzc0amswZ1BrZUMrVXZnZFZtc1MxYU5aKzgx?=
 =?utf-8?B?MGttOGhSaTVyZER1Mi9ha21pV3Y1ZlBOZlRqWVVzOFRpYldoZlVFNERsekcv?=
 =?utf-8?B?bktZdDR3dnpPOTNBODlIYmM2bWszcFRTek5LS2VJeTVvcEtZZ3NPQTAya3B0?=
 =?utf-8?B?RXVZcURJRzFCTnlPdVNGU3hhdEhiYzcraURKMm16OWpSSXdGcWdaRVViamJz?=
 =?utf-8?B?ZzBvKzErYjV0SkhkUjl1ZHdmODNhc2Q0ZnZJN0puVFo2cUo4QWVPR3lHVEpo?=
 =?utf-8?B?bDg3YjUrT2dlb2tPRXU4allCQUVWQmw0WWMxYWg2bnNlc2FzS3B3WlUxQzNl?=
 =?utf-8?B?dnVoa3ZMNXVpK2dXMDNETGVzY1A5cHVRZC92UWJYN2dmMXpYRkpaa29vVUxk?=
 =?utf-8?B?YlZ2RmVsM0l6Yk5IelZleDRmdkc1OUEwV3p4ckFjUTUrWm9uL3ArMlYrSUlS?=
 =?utf-8?B?OGRaN2ZESGhnUkRpVGIxWWpWNG90dUdkWlpYOXZTZVdkb3FmOVd3cHp4aFRl?=
 =?utf-8?B?NUlOc1JrZ2xIeGV4M0YrWkIvMmJkeEJoUkFkSkRZNVYzdVRadmlvVnhaTXho?=
 =?utf-8?B?bWRnRStvQllEb3VmZEJCT1QxQjFBVEZNRlJra1dwd2swV0tCVU5hTXFmSzFD?=
 =?utf-8?B?a3EwUUV4R3JDT0FnNDRma21Sc0doMWJ1S1VLQzRrOFNUaUZibUJBUldva25Q?=
 =?utf-8?B?K0lSTkp1c0dCTlBqZWdUTVN6UlNjNEIrZkZsQlJqQzJvbE1rbW9KcEs3OW9H?=
 =?utf-8?B?VWpXVWt0MERJeUtrVjIwWkx5bGJsVjVNL0lwTkxTUFhUdFYyL2hmMFRKZTZY?=
 =?utf-8?B?Mm8wSzB2dFFsdjR4cjFGZmU4RWpISitKSUk2ZWF2Vzd3UHJqenNvbHdUOTVQ?=
 =?utf-8?B?NzVreWxKRWZDSFdEZXlwRVlaL2ZLbnN1TTF2MU1JYnU1UlZHT1ZZUlJkbVQ5?=
 =?utf-8?B?ay9jby9KQW9VL0RmM1NxNStaNnM0M0ZFUGhoZXcvdGpWczYxNlpZZWRFWmlm?=
 =?utf-8?B?N1pibWxsV3Z5cGNHWFhkbVBiNnJrN2F3NEVLdTl0R0VUaGJaQVVuNkhNbk1Y?=
 =?utf-8?B?UVRleCtQZnlvaHhvVDIrMkt4SVZ6NHNIV1BlV2ZLWlY5VHN0OWJPMHpKanNt?=
 =?utf-8?B?VE9CWUZPelRCbXI3TmZZSEdNc3dxSjJxNnp2NkZSTWh5N05YMHdFUld0SFNP?=
 =?utf-8?B?RlVvN1VEbkJPK3RuL1AzMFFxSHZoMStQSCtwcmJCRXRwMmkvYi9aQ3FFVjJB?=
 =?utf-8?B?eTN4b1pQakdxdWV0U0RjNlBaSkxNYXB0ZlpxbUVOQTVSRTcwaWwwZGVYUk1j?=
 =?utf-8?B?YUNhWWM4eVBuV2RiQ1kyTjZQK3lxZkFjZnNNZ3N3aWxzRFFvS0RNVHBBLzNT?=
 =?utf-8?B?cU13YTNNWXp6VUdCTXptOFNFNjhCQjlsajJLSFhqdC85cHl5UUNFdkM0OTZM?=
 =?utf-8?Q?SjBykr9mT5HQwf918VtKvGOov?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12A405373693924EA6FF232CAFB35F89@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8687a01a-2f19-41df-1ce1-08dd549919bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 06:04:29.4706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ufqwkkuvFMb/H7QdoVBDzvMxkQ+g/5Jy1wGBHNVKBobSdSdZswt8DEuIMV2cWxasLi/Fuz+v9MWqpYIzKaPatg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6536

T24gTW9uLCAyMDI1LTAyLTI0IGF0IDEzOjAxICswODAwLCBKYXNvbi1KSCBMaW4gd3JvdGU6DQo+
IEFkZCBjbWRxX2djdGxfdmFsdWVfdG9nZ2xlKCkgdG8gY29uZmlndXJlIEdDRV9DVFJMX0JZX1NX
IGFuZCBHQ0VfRERSX0VODQo+IHRvZ2V0aGVyIGluIHNhbWUgdGhlIEdDRV9HQ1RMX1ZBTFVFIHJl
Z2lzdGVyLg0KPiANCj4gTW92ZSB0aGlzIGZ1bmN0aW9uIGludG8gY21kcV9ydW50aW1lX3Jlc3Vt
ZSgpIGFuZCBjbWRxX3J1bnRpbWVfc3VzcGVuZCgpDQo+IHRvIGVuc3VyZSBpdCBjYW4gYmUgY2Fs
bGVkIHdoZW4gdGhlIEdDRSBjbG9jayBpcyBlbmFibGVkLg0KDQpXaHkgbmVlZCBHQ0UgY2xvY2sg
dG8gYmUgZW5hYmxlZCB3aGVuIHRvZ2dsZSBHQ0VfR0NUTF9WQUxVRSByZWdpc3Rlcj8NCkluIHNv
bWUgaGFyZHdhcmUsIGp1c3QgbmVlZCBwb3dlciBvbiB0byBhY2Nlc3MgcmVnaXN0ZXIuIEl0J3Mg
bm90IG5lY2Vzc2FyeSB0byBlbmFibGUgY2xvY2suDQpJZiBHQ0UgbmVlZCB0byBlbmFibGUgY2xv
Y2sgdG8gYWNjZXNzIHJlZ2lzdGVyLCBhZGQgaW5mb3JtYXRpb24gaGVyZS4NCg0KPiANCj4gRml4
ZXM6IDdhYmQwMzdhYTU4MSAoIm1haWxib3g6IG10ay1jbWRxOiBhZGQgZ2NlIGRkciBlbmFibGUg
c3VwcG9ydCBmbG93IikNCj4gU2lnbmVkLW9mZi1ieTogSmFzb24tSkggTGluIDxqYXNvbi1qaC5s
aW5AbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWls
Ym94LmMgfCA0MSArKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxNyBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jIGIvZHJpdmVycy9tYWlsYm94L210
ay1jbWRxLW1haWxib3guYw0KPiBpbmRleCBkMTg2ODY1YjhkY2UuLmJlMTc2OTdkNzc4NSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiArKysgYi9k
cml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+IEBAIC05MiwxNiArOTIsMTcgQEAg
c3RydWN0IGdjZV9wbGF0IHsNCj4gIAl1MzIgZ2NlX251bTsNCj4gIH07DQo+ICANCj4gLXN0YXRp
YyB2b2lkIGNtZHFfc3dfZGRyX2VuYWJsZShzdHJ1Y3QgY21kcSAqY21kcSwgYm9vbCBlbmFibGUp
DQo+ICtzdGF0aWMgdm9pZCBjbWRxX2djdGxfdmFsdWVfdG9nZ2xlKHN0cnVjdCBjbWRxICpjbWRx
LCBib29sIGRkcl9lbmFibGUpDQo+ICB7DQo+IC0JV0FSTl9PTihjbGtfYnVsa19lbmFibGUoY21k
cS0+cGRhdGEtPmdjZV9udW0sIGNtZHEtPmNsb2NrcykpOw0KPiArCXUzMiB2YWwgPSAoY21kcS0+
cGRhdGEtPmNvbnRyb2xfYnlfc3cpID8gR0NFX0NUUkxfQllfU1cgOiAwOw0KDQp1MzIgdmFsID0g
Y21kcS0+cGRhdGEtPmNvbnRyb2xfYnlfc3cgPyBHQ0VfQ1RSTF9CWV9TVyA6IDA7DQoNCj4gIA0K
PiAtCWlmIChlbmFibGUpDQo+IC0JCXdyaXRlbChHQ0VfRERSX0VOIHwgR0NFX0NUUkxfQllfU1cs
IGNtZHEtPmJhc2UgKyBHQ0VfR0NUTF9WQUxVRSk7DQo+IC0JZWxzZQ0KPiAtCQl3cml0ZWwoR0NF
X0NUUkxfQllfU1csIGNtZHEtPmJhc2UgKyBHQ0VfR0NUTF9WQUxVRSk7DQo+ICsJaWYgKCFjbWRx
LT5wZGF0YS0+Y29udHJvbF9ieV9zdyAmJiAhY21kcS0+cGRhdGEtPnN3X2Rkcl9lbikNCj4gKwkJ
cmV0dXJuOw0KPiAgDQo+IC0JY2xrX2J1bGtfZGlzYWJsZShjbWRxLT5wZGF0YS0+Z2NlX251bSwg
Y21kcS0+Y2xvY2tzKTsNCj4gKwlpZiAoY21kcS0+cGRhdGEtPnN3X2Rkcl9lbiAmJiBkZHJfZW5h
YmxlKQ0KPiArCQl2YWwgfD0gR0NFX0REUl9FTjsNCj4gKw0KPiArCXdyaXRlbCh2YWwsIGNtZHEt
PmJhc2UgKyBHQ0VfR0NUTF9WQUxVRSk7DQo+ICB9DQo+ICANCj4gIHU4IGNtZHFfZ2V0X3NoaWZ0
X3BhKHN0cnVjdCBtYm94X2NoYW4gKmNoYW4pDQo+IEBAIC0xNDAsMTYgKzE0MSwxMCBAQCBzdGF0
aWMgdm9pZCBjbWRxX3RocmVhZF9yZXN1bWUoc3RydWN0IGNtZHFfdGhyZWFkICp0aHJlYWQpDQo+
ICBzdGF0aWMgdm9pZCBjbWRxX2luaXQoc3RydWN0IGNtZHEgKmNtZHEpDQo+ICB7DQo+ICAJaW50
IGk7DQo+IC0JdTMyIGdjdGxfcmVndmFsID0gMDsNCj4gIA0KPiAgCVdBUk5fT04oY2xrX2J1bGtf
ZW5hYmxlKGNtZHEtPnBkYXRhLT5nY2VfbnVtLCBjbWRxLT5jbG9ja3MpKTsNCj4gLQlpZiAoY21k
cS0+cGRhdGEtPmNvbnRyb2xfYnlfc3cpDQo+IC0JCWdjdGxfcmVndmFsID0gR0NFX0NUUkxfQllf
U1c7DQo+IC0JaWYgKGNtZHEtPnBkYXRhLT5zd19kZHJfZW4pDQo+IC0JCWdjdGxfcmVndmFsIHw9
IEdDRV9ERFJfRU47DQo+ICANCj4gLQlpZiAoZ2N0bF9yZWd2YWwpDQo+IC0JCXdyaXRlbChnY3Rs
X3JlZ3ZhbCwgY21kcS0+YmFzZSArIEdDRV9HQ1RMX1ZBTFVFKTsNCj4gKwljbWRxX2djdGxfdmFs
dWVfdG9nZ2xlKGNtZHEsIHRydWUpOw0KPiAgDQo+ICAJd3JpdGVsKENNRFFfVEhSX0FDVElWRV9T
TE9UX0NZQ0xFUywgY21kcS0+YmFzZSArIENNRFFfVEhSX1NMT1RfQ1lDTEVTKTsNCj4gIAlmb3Ig
KGkgPSAwOyBpIDw9IENNRFFfTUFYX0VWRU5UOyBpKyspDQo+IEBAIC0zMTUsMTQgKzMxMCwyMSBA
QCBzdGF0aWMgaXJxcmV0dXJuX3QgY21kcV9pcnFfaGFuZGxlcihpbnQgaXJxLCB2b2lkICpkZXYp
DQo+ICBzdGF0aWMgaW50IGNtZHFfcnVudGltZV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0K
PiAgew0KPiAgCXN0cnVjdCBjbWRxICpjbWRxID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICsJ
aW50IHJldDsNCj4gIA0KPiAtCXJldHVybiBjbGtfYnVsa19lbmFibGUoY21kcS0+cGRhdGEtPmdj
ZV9udW0sIGNtZHEtPmNsb2Nrcyk7DQo+ICsJcmV0ID0gY2xrX2J1bGtfZW5hYmxlKGNtZHEtPnBk
YXRhLT5nY2VfbnVtLCBjbWRxLT5jbG9ja3MpOw0KPiArCWlmIChyZXQpDQo+ICsJCXJldHVybiBy
ZXQ7DQo+ICsNCj4gKwljbWRxX2djdGxfdmFsdWVfdG9nZ2xlKGNtZHEsIHRydWUpOw0KPiArCXJl
dHVybiAwOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgaW50IGNtZHFfcnVudGltZV9zdXNwZW5kKHN0
cnVjdCBkZXZpY2UgKmRldikNCj4gIHsNCj4gIAlzdHJ1Y3QgY21kcSAqY21kcSA9IGRldl9nZXRf
ZHJ2ZGF0YShkZXYpOw0KPiAgDQo+ICsJY21kcV9nY3RsX3ZhbHVlX3RvZ2dsZShjbWRxLCBmYWxz
ZSk7DQo+ICAJY2xrX2J1bGtfZGlzYWJsZShjbWRxLT5wZGF0YS0+Z2NlX251bSwgY21kcS0+Y2xv
Y2tzKTsNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gQEAgLTM0Nyw5ICszNDksNiBAQCBzdGF0aWMg
aW50IGNtZHFfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAJaWYgKHRhc2tfcnVubmlu
ZykNCj4gIAkJZGV2X3dhcm4oZGV2LCAiZXhpc3QgcnVubmluZyB0YXNrKHMpIGluIHN1c3BlbmRc
biIpOw0KPiAgDQo+IC0JaWYgKGNtZHEtPnBkYXRhLT5zd19kZHJfZW4pDQo+IC0JCWNtZHFfc3df
ZGRyX2VuYWJsZShjbWRxLCBmYWxzZSk7DQo+IC0NCj4gIAlyZXR1cm4gcG1fcnVudGltZV9mb3Jj
ZV9zdXNwZW5kKGRldik7DQo+ICB9DQo+ICANCj4gQEAgLTM2MCw5ICszNTksNiBAQCBzdGF0aWMg
aW50IGNtZHFfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIAlXQVJOX09OKHBtX3J1bnRp
bWVfZm9yY2VfcmVzdW1lKGRldikpOw0KPiAgCWNtZHEtPnN1c3BlbmRlZCA9IGZhbHNlOw0KPiAg
DQo+IC0JaWYgKGNtZHEtPnBkYXRhLT5zd19kZHJfZW4pDQo+IC0JCWNtZHFfc3dfZGRyX2VuYWJs
ZShjbWRxLCB0cnVlKTsNCj4gLQ0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+IEBAIC0zNzAs
OSArMzY2LDYgQEAgc3RhdGljIHZvaWQgY21kcV9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikNCj4gIHsNCj4gIAlzdHJ1Y3QgY21kcSAqY21kcSA9IHBsYXRmb3JtX2dldF9kcnZk
YXRhKHBkZXYpOw0KPiAgDQo+IC0JaWYgKGNtZHEtPnBkYXRhLT5zd19kZHJfZW4pDQo+IC0JCWNt
ZHFfc3dfZGRyX2VuYWJsZShjbWRxLCBmYWxzZSk7DQo+IC0NCj4gIAlpZiAoIUlTX0VOQUJMRUQo
Q09ORklHX1BNKSkNCj4gIAkJY21kcV9ydW50aW1lX3N1c3BlbmQoJnBkZXYtPmRldik7DQo+ICAN
Cg0K

