Return-Path: <linux-kernel+bounces-209448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B5F9034D9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116381C20BC1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68613173324;
	Tue, 11 Jun 2024 08:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YkMNQXvL";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="dbWqff6c"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AE02AF11
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718093215; cv=fail; b=eDBCSSPsu0MAwEk4BDo3lSicqsOVkTT8RhOcH4txCcbvL7QnFYnFBRdjEhqQ1SZ02ZjNjXOwVmpm+O3G7W2ehu3HdTjw6sblK7xY/h9us/R/cDl2bVciLvvDiMaeK9Anv6WE3VSOwjGF5tUOzSgqtN1x9OedHZvSNkjAQjMsKJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718093215; c=relaxed/simple;
	bh=SLPGR5GcoZe+Fsvr9GZxLInuszW3Mtvgaz2UztMpYS0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gp0HQ6wmd3BxFDcx3zgMeDBVXprhS42DXRvoVELVhm0SBGNC3ux14ISblxKo7ZMNeofiZYy/Zcqloqt0WyydhrbVO1q77wq7l7+w274bWpaIKthilSoRTcvrUjkqlNTdwG4Kuoo+LKS+6ylkqjGN5WldzsUN3cSAB8FM3Y79y6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=YkMNQXvL; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=dbWqff6c; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8ca84be827c911efa54bbfbb386b949c-20240611
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=SLPGR5GcoZe+Fsvr9GZxLInuszW3Mtvgaz2UztMpYS0=;
	b=YkMNQXvLg1wLjWoHN7QqZkxXYdG7H381LJzEwpnQLm3FDjpLFlqd/fTj0YhNkN4YU3zWO9tE6Kjysf5uBnCqdplBzVHGQQRRZJDqY6MJswdPfp38UQsRb1AU1SiHAq/Be7n3vfe3Pt6jIsRQnyw+iff1Ls5zxRsKWpt8C/2rwjk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:5a3e8a91-966a-4822-99f5-d930fa7903c9,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:993cf284-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8ca84be827c911efa54bbfbb386b949c-20240611
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 601774282; Tue, 11 Jun 2024 16:06:47 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 11 Jun 2024 16:06:45 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 11 Jun 2024 16:06:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsrZnVNPm+/SCbTXHnZSY3ggr1HDdIRbajjxRPrVFhMzRr+n0zaqGr1x8VMmTUph1l27i1GdillMYQ1nO18g1HHMzCBaCBnLA132XaLtVo7j9U0ITlsPPbLDORgZXBuibf+WUy7FoJosCRpiKt1tv0KkA1Wl/DXuJq503QDly4Wb8RxLLwUQUGl2EgMUteN1CVTy4TpPm7knJeg1Tgu1RQ7hjlsKaCKxESO8GiBAbvxoIEXhdrqt8p+f/ZVw4YFpggOYBOzgNE3aZxzzTY/jumtnO9QZ+k/7ipUtvdjHpe/q6UXodfWNvf2fOp6wafZhaM34PoITYWSYp3UFsAKekQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLPGR5GcoZe+Fsvr9GZxLInuszW3Mtvgaz2UztMpYS0=;
 b=LC3XKsRoZ8jBkL1WQ0artaZmDoFHOh6ceHUyW3hJa+BQsCb4O267vLId9g6o4bwNP0lqBmdEuG4K2OF4K0SSHMrIaYwbKV/9sh963eIgPwYTRkwQsRNFqsXJ0lpxsx/GI91UV0IMYScfHAIg/VdQb84vKj3lkOtT9XH0oQ+49GqOPT/wWra0F9T+LA9V/dUzyCu5a1iV9jqP1f7oCcs90bIH+Ut69cVUj/oudszdLAMraMYJkrrlDs/qO0FZY8TC2rQD/7CKvONN4hEZFfQVrV4o46+ER+Kr2Amwxoj0R+mG4MYk/7wJq6quybqtcf/ZV5dzcXkDluIELa3AP4Jh8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLPGR5GcoZe+Fsvr9GZxLInuszW3Mtvgaz2UztMpYS0=;
 b=dbWqff6cyWfH9Lz0VHhQomsHnkRDI9URL0AbHtM+r0FfCFr/xOAxxy1wUjEVoa8quVzkvpghuCc9vR+7QQ9gWdpO//FXGsLJCsElrOG89VnA2RoZ0mNntI1svFNUOz08gRQjmCklmtOH69GAIEMXGI8sbRVG3s/ITZefyf7P5HY=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB8092.apcprd03.prod.outlook.com (2603:1096:400:464::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17; Tue, 11 Jun
 2024 08:06:43 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%6]) with mapi id 15.20.7677.014; Tue, 11 Jun 2024
 08:06:43 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"jason-ch.chen@mediatek.corp-partner.google.com"
	<jason-ch.chen@mediatek.corp-partner.google.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"sean@poorly.run" <sean@poorly.run>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "fshao@chromium.org" <fshao@chromium.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v8 09/16] drm/mediatek: Support "None" blending in OVL
Thread-Topic: [PATCH v8 09/16] drm/mediatek: Support "None" blending in OVL
Thread-Index: AQHat/PALChUuen/mkGE9n7i39ajD7HCPK4A
Date: Tue, 11 Jun 2024 08:06:43 +0000
Message-ID: <24cc46e14e96d425acaf165be65220ae6e32f5d3.camel@mediatek.com>
References: <20240606092635.27981-1-shawn.sung@mediatek.com>
	 <20240606092635.27981-10-shawn.sung@mediatek.com>
In-Reply-To: <20240606092635.27981-10-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB8092:EE_
x-ms-office365-filtering-correlation-id: 6ce8dfa7-9dd0-4ceb-fc3c-08dc89ed6e6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?UTg0VjEvS0VhVmhTQ0J6cnAwNkpicVQ3bkVUYysvdzJyb05kdk1YUktxc0Jz?=
 =?utf-8?B?WlgxREZKeHNpNWdOcHpLU002QTUxcHhQY3VXbDRUZTBqYnFwMVRRc1FhN1VT?=
 =?utf-8?B?ZDlydm41QUFxREtzV0plUEpUVlZDRkY1Z3pHbW41cHRCeVhuWVFvTklQQU5w?=
 =?utf-8?B?andHa3RmSDlkbGNuUTZYbnFXSlpZOGYwc09XaEEwb2gwNmRaUzc3UkNkbHJX?=
 =?utf-8?B?OGtiWUtkQk9VNTR4alplVm9kUDlCTENnblExWmJRYzJmQkhCSzY4ZGV0MU82?=
 =?utf-8?B?K1ZYL0NyRzAvR01sQzZzYlNEZHhkRm5ZS2dDYk1aUUxIQm03Wit3TjlacFhw?=
 =?utf-8?B?YVljTzJ0TXNGdHlKU0ptOFZuTnovazNtVURXVE43V002NTZNZER5NmVuREF6?=
 =?utf-8?B?WTIxQmlDQ1puZFdYYTZvN0MzenVHc2pyaUtSYUpxYWZwYnlCK2xUUnFKTUF0?=
 =?utf-8?B?d0h6aHZKYUhvN0tXMG1wOVhrTXE3UDlWRVZBcGtBWEJOTncyQ3lpcC9EeHdU?=
 =?utf-8?B?Q1pNQnUzYW4wczMxVHp3S1ptVUN2WC9NbmdCOU5RVmI3NDdRSDh1TE9Ga2s3?=
 =?utf-8?B?dmpTdXBmeGxPd0xwMEIrRTh1aVBsUDU0NXExWCtFR1NxNzgyRWZwWmNGY29G?=
 =?utf-8?B?STh4enc5ZmJoNnc4Z2NBazV1Y0NDRyt0MzBFb2F1M2Z1cWMrdEVQMFZpaG5M?=
 =?utf-8?B?MzVlSHhXUy9sTGdEWDVoenJSb0ZENUxBTDJFbHNxeS9GM1VhRXN4RFhINjV2?=
 =?utf-8?B?NXQ0SXdqZEFFenBScktTUWxFeEQzUGdpN2N3a2JmbUJ2NXdPQmk4UmorbkFX?=
 =?utf-8?B?Mk0xNy9waXFTSzRvN1kxZ1krVEU3Tm9PanRKZkZvZ09Sa1JseFNGdWlXOStr?=
 =?utf-8?B?cXdrVmdiQWU5K1hzUzgvOHFsSkdIQTE3eFRtTGQvNFJQTEhJN0xiNTRhTmt5?=
 =?utf-8?B?S3JubE9OaGhoUHY0KzhHWW1PQlpoQmJPTWN2cHVGME5aYnVxam5NRjg1K1Yy?=
 =?utf-8?B?dytjMEdONjM4TUROMFdzTUpNVjh0ZWtaRWZZb3ZEemk3R3RDVkd5MmR2QWpk?=
 =?utf-8?B?U1NhMjNqODRyc3NmaHRJeE5YYU5iMzlaeTdkcXkvYzRWeGVuVmR5NHZMZXBT?=
 =?utf-8?B?d2JMRUlKaTd2R2FySkFyMGVUNnM3TVNvN3JHUTM3U1lpUTd4U0NNSTBEVm1w?=
 =?utf-8?B?RzFpdktrS3Y4TlU0alUzY3VVL0ZJRTdSZ3lQTmpkN2ZkbC9GeEVtdnNuT25D?=
 =?utf-8?B?S3ZybmtXaGxvektMb21VM3F0bmpmdDNDcGo3aVcza2ZxbDluWkdNWUY3Wmdh?=
 =?utf-8?B?Y0d5N0NGbVBJcE50MUdCbWViNUpqeUt0Z3lVN244OFcrRWFnQTVXUkpYWU9J?=
 =?utf-8?B?ampGaG5tNnJGSlFKYUlYY1N4bmp4L2tEbEo2eVl4STVOMXAvR2wwdytnVm96?=
 =?utf-8?B?NFlremtSTUpsTzNCajJjNFo5TGNvYUdleXdNaUZ3Tmh4UjIvNm42dXZGME82?=
 =?utf-8?B?b2NBLzdCd1JxZW1aaVl1em1JKzQrQUppSEJIdHJNMWh5aGRTT3FsbVJJLzFh?=
 =?utf-8?B?a1RCdk9rVkxUdzNoR0dvMGlCckQxRjJXVHdBT3VmUXdFYTNCN2J1ZTRDT200?=
 =?utf-8?B?NklhREgxYUhyUHNyeVp4aFh3N0JidUJ2K1o5Nml1bCs4R3JkbDcyTllZMG1O?=
 =?utf-8?B?NjBRczhPU1hiVmdvVUY5OEM5bDlzVllBY0JtdktGMi8yS2tSMVVWam03M1p5?=
 =?utf-8?B?bkVjWGpldnlycHpNd1cxRmdyUDgwSVZLT1pUZ00wRU5qZlJwdm13NmNDc25B?=
 =?utf-8?Q?My/Pd05RAIs3uAukJl4Hk9RcHNKZNvcJx2ITQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWhzdWIxUll0T1huZ0R0SzVncE1BRWk1dWxZSGVxUjJkY24wbGdKS29QYVdk?=
 =?utf-8?B?UWUrOGpXNFhHV1dXV2VUQVhlZGowdEYvOTBpRFpsUlJ3UENwL2Zlci9PSDNP?=
 =?utf-8?B?VXI3TkhhMDZZRzBIVGFOTVY0czFRRG9hUHIybng4Q2Q2U3FsU0dOdVlQV21h?=
 =?utf-8?B?cy8yd1VGTEI0cWZrNXVLUEQzaU9zUjFoVFFIOU5ZQ21iaitkRFpGd3BLY3FS?=
 =?utf-8?B?R3dISlFSSHN0M2pBUWh2MmhncDdWZklVRXFvNmg1b0phbTJVN1lCK2swUUN3?=
 =?utf-8?B?cm9VbUExM1ZiNkRUYmtWdzlpZGxQdG51cjNySlNLa1lJYnlaNEtSZzBna1Zs?=
 =?utf-8?B?V1djYWRtVzJjYWp0dVpTV2VHejR5eTRlYk1QNitYT3kvaTVOV2FLbFJwajlv?=
 =?utf-8?B?WkE5alJTYWZXYkxFNjZUVWNSbE1kRkVqS016RXdrbnQ1QnVocytDK2dsb1o0?=
 =?utf-8?B?UzV1eDB3aG8zSWFVMkFTZXJIbVZHTmpVOVJQY240Mlg2UUFCMWFKeHp2bUVv?=
 =?utf-8?B?dW91SzRJWmh5WjdNaG5Fa3g4dzNuQ1djVFBYNUZ4ODhvS0lFRyt3OFBWVmZR?=
 =?utf-8?B?SVQyWW56UDRxM283ZHk4N1BocWRUUlR2OE9lOXNUTmVsd0VQOXBGbi8wSmJw?=
 =?utf-8?B?aG9KeGJObHE1ZkFQdmRkN1lSUUY4MXhiSDRTdEI2S2doRTBWUWw4bmY2VTI4?=
 =?utf-8?B?dEg5UjJVNFp6NXlDbmxXMmwrbXNUOGJVQUdzN2RCbVZaRmVxSWE0ODBOWVNZ?=
 =?utf-8?B?allqYUxWTmt6TmxodEYyWDRxQW9jQ2ZVVm5BRVp4Tzd1MW0rdzloWlFIQkd5?=
 =?utf-8?B?OVZ6VTgzOVJpQWFyU2NzeVJaMFJRZ2sybmZKY0d0a0Ztd2gzcHlpNm11cTE1?=
 =?utf-8?B?N0h3d3hnZHlIM1dzUk4vdzNqSTljb3ZoNUw2dS9OSWlVdDRaenZpc0VRM1FI?=
 =?utf-8?B?akxtaDliRXJZSjFTVHQyZGJ3dTh2ZTd5VGpTR3k0Znc0enhUcm1MWjFIWHJC?=
 =?utf-8?B?bkFtRFRxMFRDbU11R2tiSkFIdUtEQ1dsSDdqZkQ4N0FORTBsdExrVUZiQ3k3?=
 =?utf-8?B?Q2V1SkVmYW84cWM2dlNBTFZSd29TRWs2bitQRzBTMnU4a2ovaTlQcUViME5k?=
 =?utf-8?B?alVwMXB1dVFOS2UwY01HZ2p1ZityYU5lUUtlbHRxTkl1NlNONEpuNXNLNERj?=
 =?utf-8?B?SzhpbHRzOEZOSmJjcHFIWXFUMUdJZXlTb2FTM21hL0theXdBVHVMWENDSk12?=
 =?utf-8?B?bHcwaUkzbkhJZ21EbkVMKzVOclBIQm9kRnFwSVhwQ3EvVmRJN29sazAySHBK?=
 =?utf-8?B?UW1XNW44YU5zWVp0cXVYMTRkZUlVY3VtbmJRQkVmYS9XNW5mMldCZTJ6QkRC?=
 =?utf-8?B?WVlTOG5jNktmVU9ucmdiYUJkZTQ2TmcySUhpNE82eThTQ2ZvcnNLaVZEK0lu?=
 =?utf-8?B?OGQ5OUphQWd5VGhaNENkRG4wT1J2MzJCMmEwQjNQa1d5cFRYNWtNTkd1RlB3?=
 =?utf-8?B?bFNiUWtOYTFNN0VlQThQWUZ6Qkg0S0E4UEh3UEY0ZmhBLzZOc0N0dkhjbTZU?=
 =?utf-8?B?TzZMMGhXbmJTeTdmeFN5N1RHdXlUVFkzTTVsMGYzeHgwZDdlY3dvL1BxTzJ1?=
 =?utf-8?B?MlZhN2R6NFZxOWVRZTVmV1A3ZUxnc2N3TWsyaUdOMWs2YXZxK3d0UExqTzN6?=
 =?utf-8?B?QmlaUk15WGlscE9qUVczRkp3U1hicThPZU5nWnl4eDUzdEU4MlFSdDNkSEly?=
 =?utf-8?B?NFVXbm0zZFdCYi92dWlwdEhOZjYvdDF1cU9rSURuZGcySUZWMmliQmNicElt?=
 =?utf-8?B?SlpaVENwN280M3h2enFuMTNXTHhOMjcyNFVObm8yQWd1b2owV1B5OHZzaytp?=
 =?utf-8?B?SDloTDFrdGFmaWVlWHkwWkFNbGZnRUliSE42K24wa2o3TTFBdis4Y2RlcE9q?=
 =?utf-8?B?YUZMU0tPQlRKQjBJNUdjc1ZhbjBPaWlRVUFIWVg3amNNcjFjYWZBSi9zZXpZ?=
 =?utf-8?B?NUplSG0zbVhYREJhYVN6N3VBRmlFTFByYjJpb3QzSUtlUWNneU9VeFpaUXVz?=
 =?utf-8?B?SXBQRG9uNjZKN3hZb0xmWjA3OHF5b3NzU0l2bHBnd2RhNWRJTG9pdmg1a1Nu?=
 =?utf-8?Q?G12HdozMJniE/69YT7oXB18a8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE9F3285CC3CC944A1524BCFBBD3C1BE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce8dfa7-9dd0-4ceb-fc3c-08dc89ed6e6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 08:06:43.2200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hbpoUKCbQJHvIg5y//itKCI/s8DbBzUBHkOBRcI7+54E50wSBsrvUvIA4xlSBXA7NvV0us4E7HmkqjRO8B4cmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8092
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--17.359200-8.000000
X-TMASE-MatchedRID: scwq2vQP8OEOwH4pD14DsPHkpkyUphL9X4GSJGyYc34E6M1YtcX6vMQG
	d7R3BXX6Pkn/V88HF8sSqo3ZUfrHh25/NyTKlG69y7TSWcbz49aH7D1bP/FcOmI4wQ1Yq/d0ixZ
	NU2JZ49urXy/3bY8ejWlSWihAdtZ+XKopuL8DJvCzI1v7J4hECri8G4TZfQeV2+mPn502VC9H2P
	FX3Comq3egRv0CLAHIsWx8eTKGeuIM8jMXjBF+sNIFVVzYGjNKWQy9YC5qGvz6APa9i04WGCq2r
	l3dzGQ1v22/FeMyuDoTeeDCCefa2HyVPRVYbwNRxjC1EZVk5eOLFlBQaQU2hg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.359200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	A728D416D98E64FCE7F26A59AE6E2EE08EC738DD866153C57582419F9D6406E32000:8

SGksIFNoYXduOg0KDQpPbiBUaHUsIDIwMjQtMDYtMDYgYXQgMTc6MjYgKzA4MDAsIFNoYXduIFN1
bmcgd3JvdGU6DQo+IEZyb206IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsu
Y29tPg0KPiANCj4gU3VwcG9ydCAiTm9uZSIgYWxwaGEgYmxlbmRpbmcgbW9kZSBvbiBNZWRpYVRl
aydzIGNoaXBzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24u
c3VuZ0BtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kaXNwX292bC5jIHwgMTYgKysrKysrKysrKysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE0
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kaXNwX292bC5jDQo+IGluZGV4IDczODI0NGE2MTY0ZS4uNTRhNmYxMWFhODY3IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+IEBAIC0zOCw2
ICszOCw3IEBADQo+ICAjZGVmaW5lIERJU1BfUkVHX09WTF9QSVRDSF9NU0IobikJCSgweDAwNDAg
KyAweDIwICogKG4pKQ0KPiAgI2RlZmluZSBPVkxfUElUQ0hfTVNCXzJORF9TVUJCVUYJCQlCSVQo
MTYpDQo+ICAjZGVmaW5lIERJU1BfUkVHX09WTF9QSVRDSChuKQkJCSgweDAwNDQgKyAweDIwICog
KG4pKQ0KPiArI2RlZmluZSBPVkxfQ09OU1RfQkxFTkQJCQkJCUJJVCgyOCkNCj4gICNkZWZpbmUg
RElTUF9SRUdfT1ZMX1JETUFfQ1RSTChuKQkJKDB4MDBjMCArIDB4MjAgKiAobikpDQo+ICAjZGVm
aW5lIERJU1BfUkVHX09WTF9SRE1BX0dNQyhuKQkJKDB4MDBjOCArIDB4MjAgKiAobikpDQo+ICAj
ZGVmaW5lIERJU1BfUkVHX09WTF9BRERSX01UMjcwMQkJMHgwMDQwDQo+IEBAIC00MjgsNiArNDI5
LDggQEAgdm9pZCBtdGtfb3ZsX2xheWVyX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2ln
bmVkIGludCBpZHgsDQo+ICAJdW5zaWduZWQgaW50IGZtdCA9IHBlbmRpbmctPmZvcm1hdDsNCj4g
IAl1bnNpZ25lZCBpbnQgb2Zmc2V0ID0gKHBlbmRpbmctPnkgPDwgMTYpIHwgcGVuZGluZy0+eDsN
Cj4gIAl1bnNpZ25lZCBpbnQgc3JjX3NpemUgPSAocGVuZGluZy0+aGVpZ2h0IDw8IDE2KSB8IHBl
bmRpbmctPndpZHRoOw0KPiArCXVuc2lnbmVkIGludCBibGVuZF9tb2RlID0gc3RhdGUtPmJhc2Uu
cGl4ZWxfYmxlbmRfbW9kZTsNCj4gKwl1bnNpZ25lZCBpbnQgaWdub3JlX3BpeGVsX2FscGhhID0g
MDsNCj4gIAl1bnNpZ25lZCBpbnQgY29uOw0KPiAgCWJvb2wgaXNfYWZiYyA9IHBlbmRpbmctPm1v
ZGlmaWVyICE9IERSTV9GT1JNQVRfTU9EX0xJTkVBUjsNCj4gIAl1bmlvbiBvdmVybGF5X3BpdGNo
IHsNCj4gQEAgLTQ0OSw2ICs0NTIsMTUgQEAgdm9pZCBtdGtfb3ZsX2xheWVyX2NvbmZpZyhzdHJ1
Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBpZHgsDQo+ICAJaWYgKHN0YXRlLT5iYXNlLmZi
ICYmIHN0YXRlLT5iYXNlLmZiLT5mb3JtYXQtPmhhc19hbHBoYSkNCj4gIAkJY29uIHw9IE9WTF9D
T05fQUVOIHwgT1ZMX0NPTl9BTFBIQTsNCj4gDQo+ICsJLyogQ09OU1RfQkxEIG11c3QgYmUgZW5h
YmxlZCBmb3IgWFJHQiBmb3JtYXRzIGFsdGhvdWdoIHRoZSBhbHBoYSBjaGFubmVsDQo+ICsJICog
Y2FuIGJlIGlnbm9yZWQsIG9yIE9WTCB3aWxsIHN0aWxsIHJlYWQgdGhlIHZhbHVlIGZyb20gbWVt
b3J5Lg0KPiArCSAqIEZvciBSR0I4ODggcmVsYXRlZCBmb3JtYXRzLCB3aGV0aGVyIENPTlNUX0JM
RCBpcyBlbmFibGVkIG9yIG5vdCB3b24ndA0KPiArCSAqIGFmZmVjdCB0aGUgcmVzdWx0LiBUaGVy
ZWZvcmUgd2UgdXNlICFoYXNfYWxwaGEgYXMgdGhlIGNvbmRpdGlvbi4NCj4gKwkgKi8NCg0KVGhp
cyBwYXRjaCBsb29rcyBnb29kIHRvIG1lLCBidXQgT1ZMIGRyaXZlciBoYXMgYWxyZWFkeSBkZWNs
YXJlIHNvbWUgWCBmb3JtYXQuDQpTbyBJIHdvdWxkIGxpa2UgdG8gc2VwYXJhdGUgWCBmb3JtYXQg
cmVsYXRlZCBwYXJ0IHRvIGEgZml4IHBhdGNoLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiArCWlmIChi
bGVuZF9tb2RlID09IERSTV9NT0RFX0JMRU5EX1BJWEVMX05PTkUgfHwNCj4gKwkgICAgKHN0YXRl
LT5iYXNlLmZiICYmICFzdGF0ZS0+YmFzZS5mYi0+Zm9ybWF0LT5oYXNfYWxwaGEpKQ0KPiArCQlp
Z25vcmVfcGl4ZWxfYWxwaGEgPSBPVkxfQ09OU1RfQkxFTkQ7DQo+ICsNCj4gIAlpZiAocGVuZGlu
Zy0+cm90YXRpb24gJiBEUk1fTU9ERV9SRUZMRUNUX1kpIHsNCj4gIAkJY29uIHw9IE9WTF9DT05f
VklSVF9GTElQOw0KPiAgCQlhZGRyICs9IChwZW5kaW5nLT5oZWlnaHQgLSAxKSAqIHBlbmRpbmct
PnBpdGNoOw0KPiBAQCAtNDY0LDggKzQ3Niw4IEBAIHZvaWQgbXRrX292bF9sYXllcl9jb25maWco
c3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgaWR4LA0KPiANCj4gIAltdGtfZGRwX3dy
aXRlX3JlbGF4ZWQoY21kcV9wa3QsIGNvbiwgJm92bC0+Y21kcV9yZWcsIG92bC0+cmVncywNCj4g
IAkJCSAgICAgIERJU1BfUkVHX09WTF9DT04oaWR4KSk7DQo+IC0JbXRrX2RkcF93cml0ZV9yZWxh
eGVkKGNtZHFfcGt0LCBvdmVybGF5X3BpdGNoLnNwbGl0X3BpdGNoLmxzYiwgJm92bC0+Y21kcV9y
ZWcsIG92bC0+cmVncywNCj4gLQkJCSAgICAgIERJU1BfUkVHX09WTF9QSVRDSChpZHgpKTsNCj4g
KwltdGtfZGRwX3dyaXRlX3JlbGF4ZWQoY21kcV9wa3QsIG92ZXJsYXlfcGl0Y2guc3BsaXRfcGl0
Y2gubHNiIHwgaWdub3JlX3BpeGVsX2FscGhhLA0KPiArCQkJICAgICAgJm92bC0+Y21kcV9yZWcs
IG92bC0+cmVncywgRElTUF9SRUdfT1ZMX1BJVENIKGlkeCkpOw0KPiAgCW10a19kZHBfd3JpdGVf
cmVsYXhlZChjbWRxX3BrdCwgc3JjX3NpemUsICZvdmwtPmNtZHFfcmVnLCBvdmwtPnJlZ3MsDQo+
ICAJCQkgICAgICBESVNQX1JFR19PVkxfU1JDX1NJWkUoaWR4KSk7DQo+ICAJbXRrX2RkcF93cml0
ZV9yZWxheGVkKGNtZHFfcGt0LCBvZmZzZXQsICZvdmwtPmNtZHFfcmVnLCBvdmwtPnJlZ3MsDQo+
IC0tDQo+IDIuMTguMA0KPiANCg==

