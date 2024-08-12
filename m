Return-Path: <linux-kernel+bounces-282475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAD594E480
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 03:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C074281F53
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 01:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67534B5AE;
	Mon, 12 Aug 2024 01:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sA+qGcSM";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="KJZaVBFt"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ED9136A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 01:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723426672; cv=fail; b=diZhr7nkMM9AkEaL4y7OHb5lz786M37+rD4TEWt4PvzJU+C8gGf3589+Ykp0s0zThNQm2tx3vUQJi4R2OCF6pXBBC8PqqPDM/HkekLzqvBU28yfLMubqndtLs0zh6sf9QnGBbP8naLQMafS6GMXn4aqL3Mr3phIHnu4A2wfbBVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723426672; c=relaxed/simple;
	bh=FhSKSyGt4jZAns84XFp0v5BsKxkMCqCz40QZcHAC9do=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Eop7r0nb1TQzfNIosCmNp+rAxP80QgIrKa3QL2nWj0svp/zJId6V77w4+nSdI3Yfu9qjdJuOTz61pY3rWusq7yvBgZb4FW2Gz+styN2IYYZf1VYhjcytmg3ZUVR/QV/cPRKl9do6l39AMDbQdOdUEQM2rKnkbDtHfkm3O7vxqQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=sA+qGcSM; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=KJZaVBFt; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 77a479c6584b11ef9a4e6796c666300c-20240812
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=FhSKSyGt4jZAns84XFp0v5BsKxkMCqCz40QZcHAC9do=;
	b=sA+qGcSMOU4dbUd9Vnb9Lvb1feqq/0LXbO3cu9sjo29U6j0GlRU2Ys1wbO/koR1ql41HjDvwQufl+hqs/R3mECL9ps0DcGVjAf2Uj3pvQNVAfEjJ+t0M4J2iIHRHnMu3oPzP66LYUT6R8BJ0iFc9iAh4F6OJ9KfIgKDJYfamd5w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:78e6e859-e7ac-4b20-9750-99129f86d6dc,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:d1f9083e-6aa5-4057-84d5-0e7d47251781,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 77a479c6584b11ef9a4e6796c666300c-20240812
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 944738201; Mon, 12 Aug 2024 09:37:42 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 12 Aug 2024 09:37:41 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 12 Aug 2024 09:37:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epOJZTk5sab5/4ymgpEwsW8rKoH7h3zjH/RxtMTpBhUfMTfU0AnmwONADxi4uG1qNA47jXTzaQNiVI4zMNVRcElZ46T01lPL7TdtVChprYn6lIryGV/yY3+2NS/oR2ABp3dn3ML0iDMLgQhu7B8RUJmjV8m38LCpzI+CojwI0LicnsTuNdZDCNOUmfVgVP3ITcaz+18UB+CcK14gSGnYokm4E9dumc/3YGfi7A8mqcfB6yBgY19rBiB14PgxKnunN027EpUF3wNgPt8pCa3TrgLX0Hy8XSkMen0/Peu4dspJv9oIBg4v0jHndfywCAHJY4Y9X+8YM1CIPwiIes7qbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhSKSyGt4jZAns84XFp0v5BsKxkMCqCz40QZcHAC9do=;
 b=o9ghJJC+K6TrLTIM+l7J8fEa8+pBTdk6NhEcbWPUNbvbgCJ/5+hO9WuPj5Siyeg0GHd3Qi3tR+ti2Db1Vail4jZID4yJvrtElWqdhXYvM5Z6GnlbMcz5p5tV3TcF93C+wDMO7ZQvBvv95rdaxM+L9um1Lgd5n7CnAgm9VMPGpswgJyn6xrRalsj9++yL/6BbWMT65RTl7QNL1WHOV2H+RGUDWi5hvc6+ljEWnjmzYDKkk48EGS0XVyV9zsBRwvRUmX19BWgnJOk5zo+7hix6RwYoG2jbj+GTq4+uqpmuDTd8HYR1bZo1z9RYZq1G98hSnGoZgG5Dp5DS3HtxAsGO9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhSKSyGt4jZAns84XFp0v5BsKxkMCqCz40QZcHAC9do=;
 b=KJZaVBFtxDyIk2uUB7jOD3WmanHL06pW48L5Zl5Z2FxiI4CYGsQCESZ48sbs0S5rHLXi86bcVu7EAnGm0wWj6SaEPdv+WtIda2zCCs4TbVNPTX3u7qUX8x85FZsYFH445YxE6KX/lfvZS19hRGqEGwi/OfdtC+W7FUJ+pPR5geA=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SG2PR03MB6635.apcprd03.prod.outlook.com (2603:1096:4:1df::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Mon, 12 Aug
 2024 01:37:38 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 01:37:37 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@collabora.com" <kernel@collabora.com>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH] drm/mediatek: Declare Z Position for all planes
Thread-Topic: [PATCH] drm/mediatek: Declare Z Position for all planes
Thread-Index: AQHa2OwQyc5yyJbdQ0O2+ddwrYX1uLIi/pSA
Date: Mon, 12 Aug 2024 01:37:37 +0000
Message-ID: <75717fec36cdb4691723dfe90c406c1072462454.camel@mediatek.com>
References: <20240718082507.216764-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240718082507.216764-1-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SG2PR03MB6635:EE_
x-ms-office365-filtering-correlation-id: a5510147-1dfe-4e54-351f-08dcba6f58fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Q20yWkl5dG16aE5TM1E1ZlhPZm1ndGpQNmkyclpxVTNRQUZLWkZIbzRWMWdl?=
 =?utf-8?B?RU44U1VUYkRHaEp4MzlGTTRUVnd4SWVDUEJ2RXpUdnJUbWV2YTJ2YVpKSThv?=
 =?utf-8?B?c2xSRVpRNDJKL0k1L3VlOVNBRVE3NEM0QW9KeTduUmU3RitwOVMvdEEvWk5u?=
 =?utf-8?B?MXgrQTVlbXB5VlozQmVIbm81MmdUenR0akt3c1JLK3BQSnVBLzEyY1RTdFBN?=
 =?utf-8?B?K21McGFMUUlKSFY0b3ZyWW1vUGIvakJaczdDYndSQndrYlhVUkNsVmUxQnRh?=
 =?utf-8?B?WEZxMHg3bVNUWnlCUnp5elFxMzdNN0IxSytlMjI1MEZpL01Gam10KytYSlli?=
 =?utf-8?B?cFlNd1lVVnl4U2lmWlQzaVdxRytNRG13aTZkWjE4dnI5c05EcVRZWE01a1Bw?=
 =?utf-8?B?bGxtRTFhaXBza3U0aE0rRkFZSjB1T3ZQNCtCZkhRYWJVYmcxTXh2RU9ZMFda?=
 =?utf-8?B?UUFIdXBkTXNkU0NnT0FIUUlKWjI2UDlKV2c3TmJ4RG9UWjhHWVpLckY5YjNB?=
 =?utf-8?B?VFQ2ekFFWXdvVjQwODNEZXlHRzMyVVN6UFFkbENzUXZGMGlycjJjMkVlNkJN?=
 =?utf-8?B?T3NDQWNFZkc0N1RpTXFVSnJROE1kSnVqaldxWXI4NGs0cE9DZFpqa2tabDQ4?=
 =?utf-8?B?ZlBZS1FwYnovWjVyb3pKS0U0QmtIaFZUTk9FZkxmZlY2VzNFaWt3aExZTisv?=
 =?utf-8?B?Mm85VFFkdHpwNVExQnl3emZqa2kyQjhWM3VTTWprOEFlVjlOR1NtdExSY1Jy?=
 =?utf-8?B?b2VIeUVQRk41Z0E0SVFvd0ZlTm9lY1EwaWUzNmttSXpOM3BqT2VlN081YWVS?=
 =?utf-8?B?dXk0aG4zZGMwQnZUTkVFMzlBRXZseFNOK0NrQTkrWXRTV25GZ2hJempZajF2?=
 =?utf-8?B?NzB4bTJkMTJzeklCeWNPRzZ3STNsUDY0aWl5c0x1VktWVDZIVk9Valo5NXhm?=
 =?utf-8?B?cVVTM2xOMFZLNkZsUjUyeHJSem4ySnFSdkEySFMxRWczci9ZMEN5L2Zwakdk?=
 =?utf-8?B?NjZRT2hnOUV2NHU2dmlyOC82Z2ZrWCtiYjRWQXo4ZVlmOVRZZHlQYTQ3c2cz?=
 =?utf-8?B?TWZ4VTRubm05UHJaT1hyL3NHbitXYlVXMXFic0Q0cTFrTzlNNDFRRFM5N0JI?=
 =?utf-8?B?MzltbnpUR2tKL3lyTmtmSmVsMFBub0dTZ1pGYjV0dXhoTjdHWkxLdW1xdWp4?=
 =?utf-8?B?TSt2N1NpcVNGZUMwQmVPa0t6eU5qK0x2cFNHWkdxRlJ5b2kzK2JTNUhwVXVY?=
 =?utf-8?B?VmhOaG9ESGphak1IQ1ZQWUJRNjczbDFmNVN4UmlyTU5BVXpkK3c5N1hxYTlN?=
 =?utf-8?B?SUFybmNOc0NZK0c2Ym1YNFhGU1NOUTRoMDQyR3Rjei9QcFg4UFhITWY1M1JX?=
 =?utf-8?B?UStCK3VPcTJXTEJ2WWU2ZUdNUStkY294ZlYxNlBpM21xdWU1dHVWL3VZWlFK?=
 =?utf-8?B?amUrdmsyUDhpbGhpSkEvWFRocytsOHFCUzNTemNNQ0VoV0lNWDIxbUllQnB0?=
 =?utf-8?B?SGRLM244bWdZM2JnMXRBV0hJd01mdSsydkVsRmlHMzFJc0lkYUx3am84Q01G?=
 =?utf-8?B?b2lTR3BseFcxZ1VVaEw0cWs2YUIvSExoZTdGQm1CNW1rMkt5dmRFQy9DaVN2?=
 =?utf-8?B?S2huNWhKeGZtb0oxU2w0d291YUllQUwxWkhpZDZFTXJFWFlObnVMNXgyejZY?=
 =?utf-8?B?eFI2eXFERjY3ZmV1dWZib1JYcEZ5eDhoS0RHdlJjc25TNWh4ZS8xWHoweFMx?=
 =?utf-8?B?TFJVY29Bdlh6d3NSaUJtMnVOK0lQekJjaFJ1c2NtUzZ4eW5uS25aeVFDVWhY?=
 =?utf-8?Q?PDh8WKdvyD8cuLaSDDtkz8PDoh7IAfJnd+Nu4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFlxRWpmczBlNFdydUtPWVYrRUVFWDZwMzRTeE1OL21ic0g4bzQyWnZzc1RZ?=
 =?utf-8?B?YnhkcUNaaUp1c1hoV294enBpcjAwMUYzWnh5UzJaelVpOGlxTTFiUW8xdU5t?=
 =?utf-8?B?NGMrakFmT1dWVUZTemJBbEtPS2lEKzdsT1ZjZnFKME4vTmhMaTVvU2MvUE9N?=
 =?utf-8?B?V0x3UFhBQ2d5YkR4TnBIZEcrWUFZdzBObnNWM2F1a21MZlpOT2F3ZUYyTmNZ?=
 =?utf-8?B?cVVGZERUNGlGQ2pZZmpkaGYxOFF6TTZMcDIvN2dHUWROaUFOZDBaQis1aWY1?=
 =?utf-8?B?UFA5UXhVSjBRSUNHU3pYcGJTZW1QUk5pRU00eGN5M3dwU3pnOGNuODErdkpS?=
 =?utf-8?B?RDBzK3NQOUtPL0pQeEhQMTMyR3ozd1RiazVUMVVoNVVYN05xM0VEVFVWdjNV?=
 =?utf-8?B?eWJLd2g3TllSeUlFNGRvSWZaRGpseTJtUWVZNXRFdVFyQVkrTThHNUdiVk9U?=
 =?utf-8?B?Qnh3YStNTkxNSkk5R0ZlNW0wMldhSGpNd2FhVWliUUN4ZzZmM2ZMS3hEUDI1?=
 =?utf-8?B?L2pldW0rZHZuczRRa2NNU3paUnBOVkE0V2h4VmhoNFRSakZTV0hxcEloLzhH?=
 =?utf-8?B?NmVmUlZndnZvTkFBTmFMUE5UaVozeEhsNWtHK1NGSEh4WW9kN0FDcWpOSDlt?=
 =?utf-8?B?RFNpSUVqaFF4eE1LbmdOeDdpZzJYb0pGd3NQeE1lSXE1Q1gwYVNsN2Z0bHpx?=
 =?utf-8?B?T1FnVkROQTF0YTJFcWw5ZGVEUjhsWTZvakRIeFM4U0sxZ0MxMk1MempVY0RR?=
 =?utf-8?B?SW9DZ0Q5QUl0Q2RRYU9ZTXhoQ0hrYUpOUVJ1WHgzVjIyNHY3UHZjaklTM01S?=
 =?utf-8?B?b1JrRENPUUEraEZ6WkdjK09YcE9XYXlOT0JGSTZaVlI3MXZwMTBWWkFWZ3V1?=
 =?utf-8?B?bWwvOHZCQzJ3amkybTg2T1JvNm5nY1diMXFqV3cyUnN1UlJxckxDbk94bklw?=
 =?utf-8?B?bWswZVdjbmEwZ3dlclpPWUg4OVhwK3h1bXJtV2lvSnkvc0FwMUxVWE04SERN?=
 =?utf-8?B?MG1RN3pScHVOSzN3U1FuNWpVL3JHcDdZcHcvbTkvTUtIYkVidHQwTytpYXlu?=
 =?utf-8?B?akRzd2Yyc1hvYmh6Q1pGWldLWmpvMDMyUTBNRzFMWjBuc0FVTmg5NnVIMGZr?=
 =?utf-8?B?TWo4ZTFBU2pvZVpUMkZxZnEvVkxGalhJR25JY29mdFlSMzM4UUFZTGJBUFY1?=
 =?utf-8?B?SXFBU2VUWHVqdUxWUTd4SCtEOGtoRVdGYTV6TUp3UlVDcS90UklEaEk5QkE2?=
 =?utf-8?B?SmZ0cjNXNVIyT3hUVVoxT1VkVHV1NllFMHVsdHVWZHVPaTJnZTJld0k2cEp5?=
 =?utf-8?B?U1pOdEQxN0RsMStwUHJPeHpKQ3VnclBEQ2g3MVVkNDJJK0dyUFc3dnJKSWhP?=
 =?utf-8?B?a3hZR0pvYWZyZW11UnArSkhldWQ5eFJ2MGxaR05RcE1McFdJdkkxWDFvQUg2?=
 =?utf-8?B?OWhWMUM2SDBLb0xSUm9JZmtsZEQvVnA3MWFnWGhJemY3bmJaU2RqMWVWQnRO?=
 =?utf-8?B?RFBXNW5XenVxMVl3ZnZPSk85M0NGZW9oTzg1cndBTU1zVkthZkhxeHlkam5S?=
 =?utf-8?B?VjRZczBSL2pXUWJNOUM4cFRVM1hCK0hCNTdwS2FiOERBak5iVkFyazZLQnZ3?=
 =?utf-8?B?MFJ3blgyOElYcjFKV3owc0NSU05SQ1F1QXB0N2Yxb0RIVzBxQm5nYVEwWGFO?=
 =?utf-8?B?ZjVYS1puWmpZRjRMMlJCNm16V0VHUmVuRHFOWEtrcjhiaGRoTklvRVFjNDdO?=
 =?utf-8?B?N2lKWFJhOHZEUGozWlUwN2lsVEpnQnpTaWFPbnVkYkNGZ1hyd25aN3ZKU2xw?=
 =?utf-8?B?dS9tSnYzRSs4OEczVlM3MEV2c04xaWlqRklHd3FibXNOcS8vQ0xJUTU0b2dh?=
 =?utf-8?B?NWp4N0xrOFNmcDA1Tm5KdnNWNVFtdWhSN3pSMmNQVGNJR2lhMWdFeG5Kajlj?=
 =?utf-8?B?TFBZOHJFK29qTkluUHd3RkhoSVBRUS9ET25tQXF6N2d0eDE5T1ozdzk2Ujd3?=
 =?utf-8?B?YUhOUWZybTNzWEVhL2M2UnlFK1QxQzB2cmhOUGNreHpMLzVGY1k1M3NPT2RG?=
 =?utf-8?B?UE1KalZiN3dFY3VpZDR5QWNMNEtuRnBZakhLWDA4eUlHLzd5cWtpN1FzeG5m?=
 =?utf-8?Q?o7jyQzKviyAvPAiQUBphwWK7R?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55CC09802159544EA2C947914218FD01@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5510147-1dfe-4e54-351f-08dcba6f58fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 01:37:37.6360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 53EZkCuwyeuqqjjenx1v7/boBSJlwII2oOYcguszj4lq9lhEa4vSC893GX9elK2/553fgLUxpHrphS9xeZLoZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6635
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--14.236000-8.000000
X-TMASE-MatchedRID: hls5oAVArl8NtKv7cnNXnSa1MaKuob8PC/ExpXrHizzfTFKBkQVCsrOc
	xV7YuwThGxUX7c7hsm8Se/5qu0Owd70A9dlxahzTFDuTLTe6zcNcSMp/1+EppxSX1u8BLtZAf3y
	DEG1Wl1M11IkNRj0lEUTPGwUzV65mb3gilrWi3Gjil2r2x2PwtQrefVId6fzV82HMiBe0UlWOx7
	X7h9Du6+uE2tz9eIFdH4VA+h+lPSt/TZ/6kP79zpRrnSy7UTtbgRykyfrH1xlh2lxkfcGsFOnjP
	3BkhQdSL+uMrUIyem6Rk6XtYogiatLvsKjhs0ldUJTJpQXryEX6APa9i04WGCq2rl3dzGQ1fSiZ
	DkyWYsjSce1TxEK3XUdEkyMZACapLIUMxyGBEp6FSNZI2+ZeVw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.236000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	4EDE95438C2F2DE85E82A704D1B18DA3FF0EC62E56435AD6243ABE3349ECB8692000:8

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDI0LTA3LTE4IGF0IDEwOjI1ICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gTWVkaWFUZWsgU29DcyBzdXBwb3J0IG11bHRp
cGxlIHBsYW5lcywgb25lIG9mIHdoaWNoIGlzIHRoZSBwcmltYXJ5DQo+IGFuZCBhbGwgdGhlIG90
aGVycyBhcmUgb3ZlcmxheXMgKGFuZCBDVVJTT1IgaXMgdGhlIGxhc3Qgb3ZlcmxheSkuDQo+IA0K
PiBJbiBhbGwgY3VycmVudGx5IHN1cHBvcnRlZCBTb0NzLCB0aGUgWiBvcmRlciBvZiB0aGUgb3Zl
cmxheXMgY2FuJ3QNCj4gYmUgY2hhbmdlZCB3aXRoIGFueSBmYXN0IG11eGluZyBhY3Rpb24sIGFu
ZCBjYW4gb25seSBiZSBjaGFuZ2VkIGJ5DQo+IHN3YXBwaW5nIHRoZSBjb250ZW50cyBvZiB0aGUg
ZW50aXJlIHJlZ2lzdGVyIHNldCBvZiBvbmUgb3ZlcmxheQ0KPiB3aXRoIHRoZSBvdGhlciB0byBp
bnRlcm5hbGx5IHJlb3JkZXIgdGhlIGxheWVyIHByb3BlcnRpZXMsIHdoaWNoDQo+IGlzIGluZGVl
ZCBmZWFzaWJsZSwgYnV0IHByb2JhYmx5IG1vcmUgZXhwZW5zaXZlIHRoYW4gZGVzaXJlZC4NCj4g
DQo+IERlY2xhcmUgdGhlIFogcG9zaXRpb24gZm9yIGFsbCBwbGFuZXMgd2l0aCBhbiBpbW11dGFi
bGUgcHJvcGVydHkNCj4gYXQgbGVhc3QgZm9yIG5vdywgc28gdGhhdCB0aGUgdXNlcnNwYWNlIGNh
biB0YWtlIGl0cyBkZWNpc2lvbnMNCj4gYWNjb3JkaW5nbHkuDQoNClJldmlld2VkLWJ5OiBDSyBI
dSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9h
Y2NoaW5vIERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29t
Pg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfY3J0Yy5jICB8ICAyICst
DQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX3BsYW5lLmMgfCAxOCArKysrKysrKysr
KysrKysrKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfcGxhbmUuaCB8ICAzICst
LQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfY3J0Yy5jIGIv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19jcnRjLmMNCj4gaW5kZXggMDcyYjJmZGFlODdi
Li4zMjcyMTQ3MjFiNGQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfY3J0Yy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfY3J0Yy5jDQo+
IEBAIC04NzQsNyArODc0LDcgQEAgc3RhdGljIGludCBtdGtfY3J0Y19pbml0X2NvbXBfcGxhbmVz
KHN0cnVjdCBkcm1fZGV2aWNlICpkcm1fZGV2LA0KPiAgCQkJCW10a19jcnRjX3BsYW5lX3R5cGUo
bXRrX2NydGMtPmxheWVyX25yLCBudW1fcGxhbmVzKSwNCj4gIAkJCQltdGtfZGRwX2NvbXBfc3Vw
cG9ydGVkX3JvdGF0aW9ucyhjb21wKSwNCj4gIAkJCQltdGtfZGRwX2NvbXBfZ2V0X2Zvcm1hdHMo
Y29tcCksDQo+IC0JCQkJbXRrX2RkcF9jb21wX2dldF9udW1fZm9ybWF0cyhjb21wKSk7DQo+ICsJ
CQkJbXRrX2RkcF9jb21wX2dldF9udW1fZm9ybWF0cyhjb21wKSwgaSk7DQo+ICAJCWlmIChyZXQp
DQo+ICAJCQlyZXR1cm4gcmV0Ow0KPiAgDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX3BsYW5lLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX3BsYW5l
LmMNCj4gaW5kZXggNWJmNzU3YTNlZjIwLi43ZDJjYjRlMGZhZmEgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfcGxhbmUuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX3BsYW5lLmMNCj4gQEAgLTMyMSw3ICszMjEsNyBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IGRybV9wbGFuZV9oZWxwZXJfZnVuY3MgbXRrX3BsYW5lX2hlbHBlcl9mdW5jcyA9
IHsNCj4gIGludCBtdGtfcGxhbmVfaW5pdChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCBzdHJ1Y3Qg
ZHJtX3BsYW5lICpwbGFuZSwNCj4gIAkJICAgdW5zaWduZWQgbG9uZyBwb3NzaWJsZV9jcnRjcywg
ZW51bSBkcm1fcGxhbmVfdHlwZSB0eXBlLA0KPiAgCQkgICB1bnNpZ25lZCBpbnQgc3VwcG9ydGVk
X3JvdGF0aW9ucywgY29uc3QgdTMyICpmb3JtYXRzLA0KPiAtCQkgICBzaXplX3QgbnVtX2Zvcm1h
dHMpDQo+ICsJCSAgIHNpemVfdCBudW1fZm9ybWF0cywgdW5zaWduZWQgaW50IHBsYW5lX2lkeCkN
Cj4gIHsNCj4gIAlpbnQgZXJyOw0KPiAgDQo+IEBAIC0zMzgsNiArMzM4LDIyIEBAIGludCBtdGtf
cGxhbmVfaW5pdChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCBzdHJ1Y3QgZHJtX3BsYW5lICpwbGFu
ZSwNCj4gIAkJcmV0dXJuIGVycjsNCj4gIAl9DQo+ICANCj4gKwkvKg0KPiArCSAqIFRoZSBoYXJk
d2FyZSBkb2VzIG5vdCBzdXBwb3J0IHJlcG9zaXRpb25pbmcgcGxhbmVzIGJ5IG11eGluZzogdGhl
aXINCj4gKwkgKiBaLXBvc2l0aW9uIGlzIGluZmFjdCBmaXhlZCBhbmQgdGhlIG9ubHkgd2F5IHRv
IGNoYW5nZSB0aGUgYWN0dWFsDQo+ICsJICogb3JkZXIgaXMgdG8gc3dhcCB0aGUgY29udGVudHMg
b2YgdGhlIGVudGlyZSByZWdpc3RlciBzZXQgb2Ygb25lDQo+ICsJICogb3ZlcmxheSB3aXRoIGFu
b3RoZXIsIHdoaWNoIG1heSBiZSBtb3JlIGV4cGVuc2l2ZSB0aGFuIGRlc2lyZWQuDQo+ICsJICoN
Cj4gKwkgKiBXaXRoIG5vIHJlcG9zaXRpb25pbmcsIHRoZSBjYWxsZXIgb2YgdGhpcyBmdW5jdGlv
biBndWFyYW50ZWVzIHRoYXQNCj4gKwkgKiB0aGUgcGxhbmVfaWR4IGlzIGNvcnJlY3QuIFRoaXMg
bWVhbnMgdGhhdCwgZm9yIGV4YW1wbGUsIHRoZSBQUklNQVJZDQo+ICsJICogcGxhbmUgZmVkIHRv
IHRoaXMgZnVuY3Rpb24gd2lsbCBhbHdheXMgaGF2ZSBwbGFuZV9pZHggemVyby4NCj4gKwkgKi8N
Cj4gKwllcnIgPSBkcm1fcGxhbmVfY3JlYXRlX3pwb3NfaW1tdXRhYmxlX3Byb3BlcnR5KHBsYW5l
LCBwbGFuZV9pZHgpOw0KPiArCWlmIChlcnIpIHsNCj4gKwkJRFJNX0VSUk9SKCJGYWlsZWQgdG8g
Y3JlYXRlIHpwb3MgcHJvcGVydHkgZm9yIHBsYW5lICV1XG4iLCBwbGFuZV9pZHgpOw0KPiArCQly
ZXR1cm4gZXJyOw0KPiArCX0NCj4gKw0KPiAgCWlmIChzdXBwb3J0ZWRfcm90YXRpb25zKSB7DQo+
ICAJCWVyciA9IGRybV9wbGFuZV9jcmVhdGVfcm90YXRpb25fcHJvcGVydHkocGxhbmUsDQo+ICAJ
CQkJCQkJIERSTV9NT0RFX1JPVEFURV8wLA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19wbGFuZS5oIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19wbGFu
ZS5oDQo+IGluZGV4IDIzMWJiN2FhYzk0Ny4uNWIxNzdlYWM2N2I3IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX3BsYW5lLmgNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19wbGFuZS5oDQo+IEBAIC00OSw2ICs0OSw1IEBAIHRvX210a19wbGFu
ZV9zdGF0ZShzdHJ1Y3QgZHJtX3BsYW5lX3N0YXRlICpzdGF0ZSkNCj4gIGludCBtdGtfcGxhbmVf
aW5pdChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCBzdHJ1Y3QgZHJtX3BsYW5lICpwbGFuZSwNCj4g
IAkJICAgdW5zaWduZWQgbG9uZyBwb3NzaWJsZV9jcnRjcywgZW51bSBkcm1fcGxhbmVfdHlwZSB0
eXBlLA0KPiAgCQkgICB1bnNpZ25lZCBpbnQgc3VwcG9ydGVkX3JvdGF0aW9ucywgY29uc3QgdTMy
ICpmb3JtYXRzLA0KPiAtCQkgICBzaXplX3QgbnVtX2Zvcm1hdHMpOw0KPiAtDQo+ICsJCSAgIHNp
emVfdCBudW1fZm9ybWF0cywgdW5zaWduZWQgaW50IHBsYW5lX2lkeCk7DQo+ICAjZW5kaWYNCg==

