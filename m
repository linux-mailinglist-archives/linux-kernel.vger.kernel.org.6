Return-Path: <linux-kernel+bounces-214380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E59908372
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8429C1C219A8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCE5147C96;
	Fri, 14 Jun 2024 05:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Y0CYRn8M";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="QhTjD0Za"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BF0145B34
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 05:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718344560; cv=fail; b=kpD92K58GFfdH1n1QnQeiKN6FZCGDYW3k+ryPi8Ub91gxiiy3VBylndpLRybT8y23B7sWf5qOlIOBshCEBTFygOr4kSI1vozBqRs9Ju/5kOKvto5w9WtvB+rL28JKgGF70h5Uthc7ydOQgPXySpda8Ba0ASoMXIHy4SWSSwy4oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718344560; c=relaxed/simple;
	bh=lBrAAmR58S+pjWtwZokq/h5lI6SxV9GHooCY/SiGNMM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y5fqGQQlwin+jFV83OxiXR8gpaPUvq66kNmt+ylanKLQZVQFWICD472OoDHDLuKiPxqutvOeLomXVCa3G6gA8i/4EOHA0I9zGlPE9oyLUywUwK3YZ+MA+ij7YoQ/MwamBHGVS1Vz0YacP3YkjdhPy0j3mM7QWxpGa5cLaq9TmrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Y0CYRn8M; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=QhTjD0Za; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c2a355442a1211efa54bbfbb386b949c-20240614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=lBrAAmR58S+pjWtwZokq/h5lI6SxV9GHooCY/SiGNMM=;
	b=Y0CYRn8Mb3aSUwCfSmKK4B6Gno1TjIMvdqpDUafepojnBVIbQWtGThSX8tbxoFTt8gLSRKcYJHrxBuk0uSDFCDi1+TqPhrKtkJ2m759xHhFd5q8KlvKyD4hZQ7v+PhZPV8irgHWh6L8LU52zYCrZzqIJIQ61gEhm/IIcbWQ3L50=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:37e7bd8d-b4b8-4790-988f-4000afe0eecc,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:e8ec9388-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c2a355442a1211efa54bbfbb386b949c-20240614
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 114820267; Fri, 14 Jun 2024 13:55:53 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 14 Jun 2024 13:55:51 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 14 Jun 2024 13:55:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXFtqCWiOuuhRjyxZC0D1AErxR4qocP9b6zx11TNuAjZQCvrYA75zDLzWG1rEh5d0kNt5HWlD5A9/NUI9+1BKA8tdAEj3MlUGOyIHdF5LDP3W6Ixvu/lk0AtqG+8gThgdA/HEAbau9qERMspXN2cFOrDZRrfspvHopK0DI6Vuo+1jRG+M/KGaHaLkaY8iRR/vllSMp6JjBs2j1E3fFc4crINgJJjLE/YRvMsbbfN+WV9DfaH4LbqTPZQNRSgYlpPxRQTJ7JP2iMHmpVscHuJv/+EfVuIHPHT9IOldDzdzKHTJTKvZ52ukQDQt/sGJTBHupYk07N+m6J2PVWIThV3rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBrAAmR58S+pjWtwZokq/h5lI6SxV9GHooCY/SiGNMM=;
 b=JdMY5nO/tdPX9cpKb27EdZwT/2/2O2XA9c6aPSZ/7+armT4EUdULLURgMX5BnpqTOaBgUhuEDxbxyAqrmVarmdNSE4zDWPswbyU66jwmQ3robXxfrhtT/KBX9OljAFOsm5bryYT8s9CV75hKWh8RNjvgfzdQGG9HqEw1M7YjeHDyHZ2AhS5LEEdCE7gSGPWHgxkKdrV8SCkscjpjDPUbuyYzL0YtfTwCuBrVA1TGLmH3FDXvN+7nuq7TLryZ0OBq0WT7hscXAjYHDIpWih60QcI1AZpStD9F6Wj8VUnQ6FbXe3S/YKuHKKPof5WnTAmWRn4Z+sifG/vBrek645JyWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBrAAmR58S+pjWtwZokq/h5lI6SxV9GHooCY/SiGNMM=;
 b=QhTjD0ZaZ+rlYY0ofSX93gkSZBZ5aigL5L+/WiUUy+wcGQXSIJRwkVTctOHkRphMTS7immgpd6fxMbNsF/Wut8+gXGWmTI30aPlbbo+7BjD85p1YdRdqAfTjQxSTabvGezMXXT8MLBXJ/X0lmv3WSwWQDokWDT+vYl7VYrCG6JY=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB6718.apcprd03.prod.outlook.com (2603:1096:400:1f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Fri, 14 Jun
 2024 05:55:49 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%6]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 05:55:49 +0000
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
Subject: Re: [PATCH v9 17/21] drm/mediatek: Support "Pre-multiplied" blending
 in Mixer
Thread-Topic: [PATCH v9 17/21] drm/mediatek: Support "Pre-multiplied" blending
 in Mixer
Thread-Index: AQHavgU2TL5i/EmrDUSyn0fl4j1BwLHGwvcA
Date: Fri, 14 Jun 2024 05:55:49 +0000
Message-ID: <7e0253ff9161a962779b4d44dbf3e8e13dc28457.camel@mediatek.com>
References: <20240614024620.19011-1-shawn.sung@mediatek.com>
	 <20240614024620.19011-18-shawn.sung@mediatek.com>
In-Reply-To: <20240614024620.19011-18-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB6718:EE_
x-ms-office365-filtering-correlation-id: a71af6be-c568-4cb1-0420-08dc8c36a440
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009|38070700013;
x-microsoft-antispam-message-info: =?utf-8?B?QjBZQ1F3bCttenBLbEJteDZGdnVncTBUVTh2MW4zMHJUaEFmWC9FUlEyVG1h?=
 =?utf-8?B?Yk1rcDd5TzU1ZWdNMi9pUkhRM2dNQVFLV1dQMzNLNUgzS3FFRlZIYWdPVkxz?=
 =?utf-8?B?VGxOUmVzeTAvTkkwTUNDOVdoUCtpdENWTnZNQWpsWUhCcHpxa0ZKVVZia0Ru?=
 =?utf-8?B?RTc2T3RveWhXLzRuemxZVTlDTWgzbzIxZUJaZGdrZmxJSkYyNzhLa0gwcnp6?=
 =?utf-8?B?U2ZiZVQ3amVGZTVLM2lTR0s5eVFxcXFERDBQNXJhV05oUDJOYTRtT3hVS2Nh?=
 =?utf-8?B?ZitobHIyZnByV2xBOW01ODlTL0hlVHpOVTA2M0NENDlUTTQxc3VTV0RpMytj?=
 =?utf-8?B?UlprWExIMUlXNWhHazArS0FHT3VpUElJVmZCd0R2RnByNVdWdkJROTk4VGpa?=
 =?utf-8?B?NG5ST2N3cVUxWEJOREFvN0c2R3ZYWG1xb1VqTDlQNTB5SjJreC9vc3pYSUt2?=
 =?utf-8?B?NjRGNnlUZFFhUWw4S3J1clJpSmQ4TEhWQmh2bllBeGNjbSsrVDJ6V3RnZTE2?=
 =?utf-8?B?c09LM1luTTVvWkF1d09pUUhSNE9EREFkL3Zsb0kxd041ZHNpbmpYeFhHZThN?=
 =?utf-8?B?N3JPd1lKQkNsejVRb3ZnYWNiZ0dRd3pYV2hLb1F2bUhSV0pBSmI4UVBjOHBY?=
 =?utf-8?B?cXdpMVFhbzZIMkxLVCtxbzlNcGttQnE1aCtmdzRKVGdZWnNINmFOQVlCTjJI?=
 =?utf-8?B?M3lyNVgrcXV2SXhMMGRvRUhzQnpySVFWU25QWlRXSk9WaUNNOG9PeVFPUFRy?=
 =?utf-8?B?MkFGb1V2YVJ1aU1jbHE3bTZqU0p3YmF6Vy9vTFFFQ2hFSE81a0Vzd284VDNS?=
 =?utf-8?B?aHBDVE16OFRYdXhXNXhoQk9MeVRpZ2lTR0FrMlVZVGlQaWp4QlRKdGFKRHFv?=
 =?utf-8?B?Y1V6Mmp0VlMrTk5wOHowTFl2UkNIMmtnTW9CNERNSldQQzBIWVNOVEtlRVVR?=
 =?utf-8?B?bEgxa3FyQ0dPMzYyUW4yV3AxUWxSRmszWGFjbGg3dDZ0SDdEbldpSEVMZVhi?=
 =?utf-8?B?bmE2ekJ5NkxSbFExSW9pZk5yVWovZ3IvSWNjeENwbFBreFdQZ1FLKzIzSENR?=
 =?utf-8?B?OVZzQTdIL0thUU5OMGFNemVqU3NLY09kN2dxcXhGZ1BtWEcvR2ZVNXZGRWJI?=
 =?utf-8?B?d09WcFdsZGYwYWtqSkhyejVJd3puM1JZd01JeXRLQWJRMGZKeE4wNTdFajlw?=
 =?utf-8?B?SStTRDRrUnB0cEYvV0xzZUZGenFIRGw4T1h4YkxjWDBOS0tINnFYY3BOVjhC?=
 =?utf-8?B?bDZEdm4rV3VmKzI3b1ZrN2RDTVhvZ3pUb1ZVQW1XTzNCSHd0M3FwOFNRc0hj?=
 =?utf-8?B?SlJWbVFFUHpMNkFHeDQxYlRPd0JYKzk2eUZsYUJLWUFhaE52UklWaFRvL01C?=
 =?utf-8?B?VmlUWVlIdmo4a1Y4WFVyY3p0eW9GOENGUUd6Qm90MzF0Q0NLcTBnVkphR2h4?=
 =?utf-8?B?WERTSUU2NG1BQU5SbldaRGNFTHc4SEIzMGNYTERaMVNXWEJrUDBPa1JLN2FG?=
 =?utf-8?B?TDRiMFR5ei9LZVpQRVRBdHkrQ1RYVDNnVGh1NVY5ajZVYnovNWc0ZVd1Sldu?=
 =?utf-8?B?eVBKSXVLbUhGbXBnczBOblE0WEt1QXNQUk5VRXpneVl1L29HQ2xyT3R0d0ZL?=
 =?utf-8?B?QUx1cVBTNGR5WnpwcXF5NXlxY1JNZCs0cTFzZjF2TEFqb2hnRXNUSEN4ZDNV?=
 =?utf-8?B?OGwveElON09Ia3ZRc2QzakNEeVlOenRtWmM3UmdtYWs1bEkrMTlVZW8zYita?=
 =?utf-8?B?bDJEZk1SckhJQUVuT2ZodENMb2JENHpTS2xDUGpjcWZ3WjdTb2doMEVDOWg5?=
 =?utf-8?Q?H+OxftKo4Eq536nlBzaLptdKJBA0jD5p9xtAY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0JEQUtMY2pSUEJmV1lHQU9NYnU1RVRRRmxyWE9zbDVSNXl6VHMvQjhpdzh0?=
 =?utf-8?B?V0h4MFU4ejlZbmkwRENRbit5L0VmZlM0MjJtV2dNdmR1UTZyZHNyOFNTQkN3?=
 =?utf-8?B?bi9PVVRzbXNxYjA0cnozbHIwZmF2SWdXQmtYSU9GOXU4bkdQSGZ2bUIrRnJQ?=
 =?utf-8?B?RFlYZm4zZUwydmtYRVJRQTZaL256Z0pqRXVZeXJBZ1RXZExTU0FOV0NGQVgz?=
 =?utf-8?B?T0VPVk9OOUZqZ0RiSjRVd2l5YTdkZEQ3ZncvWklmNWpQa1VRVDRaTEtRaW5z?=
 =?utf-8?B?WjRNV1p3Tlg0UVQydytrR01FVDk4TTdFRVM5SUdrYXRvc1E4U05uaVNML1kz?=
 =?utf-8?B?TGZmTDRGZm1XSU4yV0RmK1ZlWUpMazBDalJtZjRoUGJCWWF0YVZIVW5wMVQw?=
 =?utf-8?B?ZEU0My9XWmFpS1Q0enFudkhEa3lRTVptVFVzUDlkL3gvSXM1M00zcW5OajZH?=
 =?utf-8?B?RmwyQ2dVdGpsYXQrWitiVitJMkgrdWRZa21KajV3WllTcVZoTWpEN3ZDSUk0?=
 =?utf-8?B?cGxWSG9yQkd1d25uN29DQWhCSTd3SjBHT3cvN1R1blNkV1ErcXZsRSt3TW1o?=
 =?utf-8?B?WjNMY3lFSDhabzVIZ24xamFISHFlbG1XYXAyUmx5aTAxbzJBdndyaEo2a09w?=
 =?utf-8?B?Z1lWREF4Si9WbDhqOGxoRmpaZUpkQlBLdmdHNFczcm96S1BHYTNhY213QThS?=
 =?utf-8?B?cGNpT3A4bGQvQXZ0bnNjeEJ2VzJiemtrVStPSXRrTVk3OW44cUNSbjd5NWVq?=
 =?utf-8?B?WHpxSVM3ckRyZHQ2Z2tOaFIzblVYa3ltc2luSGdyTWlCM2JQamNZam9nY0pC?=
 =?utf-8?B?YUNNUmJLSFhkekVaRDJPb0FHTVdSUVlqdFZNK1o3dGJqa0NOS0Q5eGFJL0VR?=
 =?utf-8?B?cDlraVJwUUIvRjNrWWJuZlJ2WmJIQnZEenNYVXYzSWpxK0w2TXd4Nk0yUC9m?=
 =?utf-8?B?MmhNMVlKZTV0NnQybWlIcDJuTjYvYm84c25SZjlheUxpZFlSVS9mMTI2K1Vk?=
 =?utf-8?B?elZjc3YwMU4rSGd1Z3NEbEJSNUtNK0ZWK0tnSWtGekt4eXUzcmcrT21GYnY2?=
 =?utf-8?B?ZVVZOCswYnF2MmFPYlg1WEszSWM2ZytvVnVBOWpNR09kTmVOMVcrT3dUQjZO?=
 =?utf-8?B?d2ZtMnRHcmR2WGw2bDBSeVlRcnplVmdoTHJtM2U2dXRtTEU0QitjOWE1Zm1S?=
 =?utf-8?B?RGJlUzVpa1RjZ0VzR3dFNWRIOE5NckJoSk5oaEJoOWxCdUZ2ajJsK3FJUzN3?=
 =?utf-8?B?cUpMMDR0QTZzWFQxWGJxTXIwTnE5MVB4M2p6eGcydkV3R000YWNtZFE3eEsy?=
 =?utf-8?B?SGdieGtyRDdYRTh0aUMzTkxYV1gzQVozVlp4K0lEak9rMnpKUnhvcTJvSjJR?=
 =?utf-8?B?c3JqNE4rQitYa0tIaDBKeloyKzlIckhMdmtBUkhsbTZuUjFTZHovRkZHbW83?=
 =?utf-8?B?Tlg0S1hHVDVUS0g0SVE4T0ZFK0pnenU4Y1hGTkdTKzZPaGpqc3YxN3Qxa1Rw?=
 =?utf-8?B?M1FXOUZKVUpFeS9OT0JldTZaOU5RcVVpTG1VOTUzSkRxTFNlYVQrM2lxaFJh?=
 =?utf-8?B?eSszdnZuTHFHTzFVOWg2ZnVRTDAzUHRIa0ptYUVlelpQMEVKYkY2S09sazBq?=
 =?utf-8?B?SEF6VHZTY01jM0dvSkZYQmd1emdaWmNEam4ydmFZVmczS1gzRjVwS3JXVFpJ?=
 =?utf-8?B?ci9EQThMYWpQMFh3YUVITkM0K3BIVytzZEIvRGw1YUZqZWFTM0NTcnM1TllJ?=
 =?utf-8?B?RS96NWppMHNybnREK1ByTHFQNHFYNG42VzVNTkUvR1J6L2gxakx3akY3eXRR?=
 =?utf-8?B?b3h1WnFrSDQ4aFo3cWVBNlY0Z01QZDVCSWdSeXJMK3pGSmsrcDhlMW51Zzhx?=
 =?utf-8?B?RTBQSjdoUERYejlySmtiQ21WZ1Y4dmIwMnIyciswRlNhRm5JTWh0M2hyNWMw?=
 =?utf-8?B?RmZsOG1vYXZuQlZBSXVvaHdxRTg4QnJwdEMwczVEYU9tM0hvQktVSkcvaXJD?=
 =?utf-8?B?UTFJbGpxcStUMDAvT2FlZVMrNVdMeVJ0bDlGUFJ1NU9COUU1K2xvZ1FwWXFX?=
 =?utf-8?B?SGxhWER1TEJEWGVyQk9QejJMMlFweEZSa2cvQ3BmbmFKRSsrWlRqOUxremww?=
 =?utf-8?Q?7GV5nbl8ZoyVRASdge5tQEbmq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5DDBC2F3B3992489E7E36AB685AF606@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a71af6be-c568-4cb1-0420-08dc8c36a440
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 05:55:49.1133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qHoan9ueInI1KD07Rif/ttiFRCxr7xddkAOCZtoRqJ0rqrAeeSg9NOYIcmVSrwXRyfVxCrcd+ueSJ8sZj+Ez1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6718
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--10.664600-8.000000
X-TMASE-MatchedRID: nVQUmLJJeyYOwH4pD14DsPHkpkyUphL9X4GSJGyYc34E6M1YtcX6vMQG
	d7R3BXX6Pkn/V88HF8sSqo3ZUfrHh1SU1d+VJ4Ijj5hLPCX3ZdOusS9CiBzL8RS11FlOYRohG0A
	D4IFm/o+bn5kxyyE8zutDoO3jgs0wLEThhTV+Wa6NzYJBKgDdEX0tCKdnhB58pTwPRvSoXL2y5/
	tFZu9S3Ku6xVHLhqfxIAcCikR3vq8xkfvZBfBfzEkMs7ABOHX+L5nRCLmmbr4gkpkHoJlDDa+eD
	UEsES44
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.664600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	B8815977C6466FB6E095F3663F43315F7969CB190C5C224E2B287DCCE58981DF2000:8

SGksIFNoYXduOg0KDQpPbiBGcmksIDIwMjQtMDYtMTQgYXQgMTA6NDYgKzA4MDAsIFNoYXduIFN1
bmcgd3JvdGU6DQo+IEZyb206IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsu
Y29tPg0KPiANCj4gU3VwcG9ydCAiUHJlLW11bHRpcGxpZWQiIGFscGhhIGJsZW5kaW5nIG1vZGUg
aW4gTWl4ZXIuDQo+IEJlZm9yZSB0aGlzIHBhdGNoLCBvbmx5IHRoZSBjb3ZlcmFnZSBtb2RlIGlz
IHN1cHBvcnRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhzaWFvIENoaWVuIFN1bmcgPHNoYXdu
LnN1bmdAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZXRoZHIuYyB8IDEwICsrKysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19ldGhkci5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19ldGhk
ci5jDQo+IGluZGV4IDkwN2MwZWQzNGM2NC4uMGFhNmIyMzI4N2U1IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2V0aGRyLmMNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19ldGhkci5jDQo+IEBAIC02LDYgKzYsNyBAQA0KPiAgI2luY2x1ZGUg
PGRybS9kcm1fYmxlbmQuaD4NCj4gICNpbmNsdWRlIDxkcm0vZHJtX2ZvdXJjYy5oPg0KPiAgI2lu
Y2x1ZGUgPGRybS9kcm1fZnJhbWVidWZmZXIuaD4NCj4gKyNpbmNsdWRlIDxkcm0vZHJtX2JsZW5k
Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvY2xrLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvY29tcG9u
ZW50Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4gQEAgLTM2LDYgKzM3LDcgQEANCj4g
ICNkZWZpbmUgTUlYX1NSQ19MMF9FTgkJCQlCSVQoMCkNCj4gICNkZWZpbmUgTUlYX0xfU1JDX0NP
TihuKQkJKDB4MjggKyAweDE4ICogKG4pKQ0KPiAgI2RlZmluZSBOT05fUFJFTVVMVElfU09VUkNF
CQkJKDIgPDwgMTIpDQo+ICsjZGVmaW5lIFBSRU1VTFRJX1NPVVJDRQkJCQkoMyA8PCAxMikNCj4g
ICNkZWZpbmUgTUlYX0xfU1JDX1NJWkUobikJCSgweDMwICsgMHgxOCAqIChuKSkNCj4gICNkZWZp
bmUgTUlYX0xfU1JDX09GRlNFVChuKQkJKDB4MzQgKyAweDE4ICogKG4pKQ0KPiAgI2RlZmluZSBN
SVhfRlVOQ19EQ00wCQkJMHgxMjANCj4gQEAgLTE3Niw2ICsxNzgsMTEgQEAgdm9pZCBtdGtfZXRo
ZHJfbGF5ZXJfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IGlkeCwNCj4g
IAkJYWxwaGFfY29uIHw9IHN0YXRlLT5iYXNlLmFscGhhICYgTUlYRVJfQUxQSEE7DQo+ICAJfQ0K
PiAgDQo+ICsJaWYgKHN0YXRlLT5iYXNlLnBpeGVsX2JsZW5kX21vZGUgIT0gRFJNX01PREVfQkxF
TkRfQ09WRVJBR0UpDQoNCkkgcHJlZmVyDQoNCmlmIChzdGF0ZS0+YmFzZS5waXhlbF9ibGVuZF9t
b2RlID09IERSTV9NT0RFX0JMRU5EX1BSRU1VTFRJKQ0KDQpiZWNhdXNlIHRoZSBmbGFnIGlzIHBy
ZW11bHRpIG9yIG5vdCBzbyBub25lIGJsZW5kIGFuZCBjb3ZlcmFnZSBzaG91bGQgaGF2ZSB0aGUg
c2FtZSBzZXR0aW5nLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiArCQlhbHBoYV9jb24gfD0gUFJFTVVM
VElfU09VUkNFOw0KPiArCWVsc2UNCj4gKwkJYWxwaGFfY29uIHw9IE5PTl9QUkVNVUxUSV9TT1VS
Q0U7DQo+ICsNCj4gIAlpZiAoKHN0YXRlLT5iYXNlLmZiICYmICFzdGF0ZS0+YmFzZS5mYi0+Zm9y
bWF0LT5oYXNfYWxwaGEpIHx8DQo+ICAJICAgIHN0YXRlLT5iYXNlLnBpeGVsX2JsZW5kX21vZGUg
PT0gRFJNX01PREVfQkxFTkRfUElYRUxfTk9ORSkgew0KPiAgCQkvKg0KPiBAQCAtMTkyLDggKzE5
OSw3IEBAIHZvaWQgbXRrX2V0aGRyX2xheWVyX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHVu
c2lnbmVkIGludCBpZHgsDQo+ICAJbXRrX2RkcF93cml0ZShjbWRxX3BrdCwgcGVuZGluZy0+aGVp
Z2h0IDw8IDE2IHwgYWxpZ25fd2lkdGgsICZtaXhlci0+Y21kcV9iYXNlLA0KPiAgCQkgICAgICBt
aXhlci0+cmVncywgTUlYX0xfU1JDX1NJWkUoaWR4KSk7DQo+ICAJbXRrX2RkcF93cml0ZShjbWRx
X3BrdCwgb2Zmc2V0LCAmbWl4ZXItPmNtZHFfYmFzZSwgbWl4ZXItPnJlZ3MsIE1JWF9MX1NSQ19P
RkZTRVQoaWR4KSk7DQo+IC0JbXRrX2RkcF93cml0ZV9tYXNrKGNtZHFfcGt0LCBhbHBoYV9jb24s
ICZtaXhlci0+Y21kcV9iYXNlLCBtaXhlci0+cmVncywgTUlYX0xfU1JDX0NPTihpZHgpLA0KPiAt
CQkJICAgMHgxZmYpOw0KPiArCW10a19kZHBfd3JpdGUoY21kcV9wa3QsIGFscGhhX2NvbiwgJm1p
eGVyLT5jbWRxX2Jhc2UsIG1peGVyLT5yZWdzLCBNSVhfTF9TUkNfQ09OKGlkeCkpOw0KPiAgCW10
a19kZHBfd3JpdGVfbWFzayhjbWRxX3BrdCwgQklUKGlkeCksICZtaXhlci0+Y21kcV9iYXNlLCBt
aXhlci0+cmVncywgTUlYX1NSQ19DT04sDQo+ICAJCQkgICBCSVQoaWR4KSk7DQo+ICB9DQo=

