Return-Path: <linux-kernel+bounces-214375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3E4908366
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED18F1C20FDB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535C81474B1;
	Fri, 14 Jun 2024 05:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eZlChZ8D";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="O+6anEja"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596A7145B34
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 05:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718344201; cv=fail; b=c4WfMRdfouKpLnH7L3+As5ij9PRaJjJr3e4guvT3LKM1OvAaseXtzV49Nw61WPNbol6GrIbJyKD+KexHsPe1GXS96RyXtelTiyjCCZ/EoLeFhI33LdjHZpmV2iy/QOFlnvgVSMfNFaFBZqeZBxakvFH/BW9PLeGRPwaHzVuw1v0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718344201; c=relaxed/simple;
	bh=Ry1ahNJEJO/kyu1b2JMC9eAQKK7fuNVYsFPYtleHUZA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mjN1LEjTmZAkTQAMGSnujLVrdbCk18DzhkdCh4G/DQTckYkMxAY+yYpZD9+VKm6ncIghaIc3nuAYfm+C2Urd14yXz/zLqb3UPFeX0o5GyKqwVEGzU1e0+F7F0SVOdX5QlVykzS0GZSIJqAdqLAqr5zlr5lQl3eI8nVUHU43vHkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=eZlChZ8D; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=O+6anEja; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ebe134d62a1111efa54bbfbb386b949c-20240614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Ry1ahNJEJO/kyu1b2JMC9eAQKK7fuNVYsFPYtleHUZA=;
	b=eZlChZ8D08U6xKoEsTC2TdZEDSbzv4hvdDTapvFdP4gOCx85bUq/wY71K+yDeIQwcqb4uwvPqOvlj0slSU54kvaOD4zN2VAVkCjSz1y0G6rvjJPzL6bxdNa8F795gG7yG9YK9r6HbxMO1YuIpY6MCk7yPrMxk5wZ4MdMFeC/m5A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:e76807e3-b136-490f-9171-6f983a4b7405,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:ceda9388-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ebe134d62a1111efa54bbfbb386b949c-20240614
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 927733411; Fri, 14 Jun 2024 13:49:53 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 14 Jun 2024 13:49:52 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 14 Jun 2024 13:49:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLdByBX36lo5FzzSsn64t3jnwQ681ukx1WeNx2XfNeaMHwu8gjiPiuGXo3ews85/XBoGOnxNj8INO/myB72YFSfTcSz/wUzWuLjbi2BwcD8+sfesINqG6j7hvGIqsiJfS3DmTWgvG2or2WJu5bvlK2bHDRe3M39ASf68upyqQbNUKhhFxFAV/6mPM+xGa6TZAg/6SOSbDImZ5yoWVz+fQwpnKoIe1glV3TMO187o+fs/ba9UTyla4UA3oNYQE2Lwz4+C5ftOSBgZZV2shmzZ1+qWUcYeXlopx6ZwkILlQhrEuq63li/IqpjhdHpqexcvvP1RuaFIyg3YsCajpRi1cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ry1ahNJEJO/kyu1b2JMC9eAQKK7fuNVYsFPYtleHUZA=;
 b=C0H+ZfvtbkqH2i6PpKfiQHXKHImdD56NbuVIIZwl1m2Id+aHvcnLdkZcZ/UAlRAigAfwHEcFlyUtN6tvMH5n9XNGIFJqBEGC/p+Zak2S/jPpGL6o6+tYrruiyVRE8YJfJhGVYcdGKIqA4PfgFPC0fB3k00xscaprViOf3j6+8jr+VesjyzsIHS1v72EaO5SeGh2ZbOsXpIfTd5skUC/UQNcgdW5SKm0llhxeGH/9IF+CjoG3OgQkvxvlW1+NLnooLZ1aM4pU9RnnpF2ry9CNs9TcbRotgvyM3TnMMHnQzO3s/sxSgk3gBJLrmlQtCJa3ndI7wFbKhOgBc3t4hI38pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ry1ahNJEJO/kyu1b2JMC9eAQKK7fuNVYsFPYtleHUZA=;
 b=O+6anEja9Dmn3fLVD9J5LKIJg4pRBrIdz2rchwWx30DWcV6IkLi99XWSsiE+7PMiJ+/cRq5hOGvB/oDHNrra0xvFhOjTbGSjpKusmGOFGabswRFVrMgjbWbmigFEfLuxO58kz0aveQbANNcB7iFqAOxo8/tVecO4rD7B7A0zgH0=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB7318.apcprd03.prod.outlook.com (2603:1096:400:424::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 05:49:49 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%6]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 05:49:48 +0000
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
Subject: Re: [PATCH v9 16/21] drm/mediatek: Support "Pre-multiplied" blending
 in OVL
Thread-Topic: [PATCH v9 16/21] drm/mediatek: Support "Pre-multiplied" blending
 in OVL
Thread-Index: AQHavgUxkv27uBRE70eZOpVJTFpNt7HGwUoA
Date: Fri, 14 Jun 2024 05:49:48 +0000
Message-ID: <b4e56c9b43031cb7cc9bb67b8114d68d2701c155.camel@mediatek.com>
References: <20240614024620.19011-1-shawn.sung@mediatek.com>
	 <20240614024620.19011-17-shawn.sung@mediatek.com>
In-Reply-To: <20240614024620.19011-17-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB7318:EE_
x-ms-office365-filtering-correlation-id: bd18192d-afaa-48de-11ab-08dc8c35cd86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|1800799019|366011|376009|7416009|38070700013;
x-microsoft-antispam-message-info: =?utf-8?B?clBxMFZGSlp5dWpYU2w1U0VkeTh3NkY1V1hwbys1VE9IK202b3FjV3d2bS90?=
 =?utf-8?B?RXd4OUpFNmlHWnUxdklLa3FXaDlzQ0psZXpZSnVMZk5oVXBUMnQ0S3lIUStO?=
 =?utf-8?B?V1VOQUY3YndxMWJEVzNjOU84SW0ySlNvbnhSeTdsUXlxQ3lLNkFnWmNtenpo?=
 =?utf-8?B?VmdWRk9XM09rczdYaElQVzBJU0pwczhTZk8wSFZUeFl0Qmg0VktjczFTNFRr?=
 =?utf-8?B?T2plUVkzTkdNbk9mOE45UzdNWHNUOVpHRlhGOERmSisrN2NMSzR3YUthWTAx?=
 =?utf-8?B?MjdwcURlQkZaVjZUcXdDREdoVFU2M1hFVEhKaTRlV3hKcms4WHdKenlHQ29Q?=
 =?utf-8?B?M0RkTnJDT0hUWE8ydVRtQVBpRjZ3d05mRHo4S1kyY3RxeFBLZ3lSazFSNGxY?=
 =?utf-8?B?VWVWVjlPRytKU21WajNCWTRQSkJlSjlrSGhMYmZjZWw4WnVWVDVZT1R0Nndh?=
 =?utf-8?B?V0ZRMC9EWTBGZW5jMGIvUEFBaEZiOHdWUUdaSkJJZHNFU1pWbFYzR1hjTkNC?=
 =?utf-8?B?RjRmSWF5Tnczb2FEbSs5M1lWZ1UwTDZJblhxUnIrcURlODBXdktoZ3BxcGlH?=
 =?utf-8?B?MlN5ZFU2VityQ1RKUlpCQ3FIRG8yOUR5RTMwbW9XR3FtMHRYWGg4OXBrdHNy?=
 =?utf-8?B?WjVyNHB6OE9id2s5VVVwRXpudjQ0L3JjLzlBZjZnUnVrTUxFSmFERkZXQTd3?=
 =?utf-8?B?WDFzMHBMUEdiNEJ5V3dUT0tOMjBNTXdhRVMrUFcyWFdaK21MQnJ0ZUZ4MCtU?=
 =?utf-8?B?ZXlsK3E3ZUJpUTg0b290VVMvRXBFWXUvanNwajZzZU1jZE0yNVlzYVI4cDBN?=
 =?utf-8?B?LzY5ZnpBZ1BEV2ZlMmdrRlpWM0xuVzBhL3Z1aWlLTmZaQ3M3bENEQkRvTGR1?=
 =?utf-8?B?dlMyZ2dmM1BUT0FKcmpFajExNmdLMUNtSEtXZTFkMkxsUlI3THBFa29wVmFJ?=
 =?utf-8?B?c2NEb3hhU2RuZUsrSDJiVnByR0Vld2ZGUjR2YWVidzYzN21DT2ZsM0V5WUNj?=
 =?utf-8?B?NGo5djM5SWJha0NPejZUKy9kVjMwTTE2TWxpWFpTaW1INnBhSmtCUVBwdll2?=
 =?utf-8?B?TE5BbXhjQmM0c1V2U0tJdXJ5NVBkSUFmZEpXaXBYZEN3L2xpN3RCNTYyYTda?=
 =?utf-8?B?RzBZZHFtQWVJREFkU0hqNTlUYlQ5WVFyUXBiZ3c1alZPUkNybHRSc1Y5SVJK?=
 =?utf-8?B?RG5ZSWFVTG1PWHZBME5VdXpnYUtZL0hjS0RnbWgxai9ERm1HSlcvT0xwR1Mz?=
 =?utf-8?B?cm1vUmtvcG80SDg4andzUHcwN1NsZ3hGSzR2dnFIRVJsM2JGUG5RSmgwbFRI?=
 =?utf-8?B?MEtPVVlXb0dEeVh1SVljd3p1TU9NWnhaSzFTZFVtenp6N0E0SkZsb0xPZWpw?=
 =?utf-8?B?R2FYQUk0bHZVN0FuUCtxNzRwaHRrU0c2d2o0OHliTmtkRFN5dnorVCtsbjVY?=
 =?utf-8?B?dWROL01SeitPU2NjcStNeE9kUStEM3k1ZStBWEFkNXNYMTBIUW9NWFVuN0dI?=
 =?utf-8?B?aHdGY0JzYzQzYm1VZ1c4MjYwbFBNZWdvSGtvdmNnQXhmZklOeHpjZzNyQmhz?=
 =?utf-8?B?Ull2VjQ4UUxGcEdXUlhqU2ZNVzNLOWVBUjdWWUlhcWxXSmNDZ1AySEFnRjRN?=
 =?utf-8?B?MHFETHlFemdPazRMTlh0OEFub1Q1Zk9xeHlvaFY2V2UyTVVtUGpJWDJmVmli?=
 =?utf-8?B?ZmlBQlRCRk12RUphQ3Y0ZFQzQTFtN2tERWhFN2Q5amVFWHJRdUtPVHpQT3oy?=
 =?utf-8?B?c2QwTStjNVN0b3lqU0hsczhCT2lEYU8zQ0NPMExyS3E5MEhrRysxUzhva09C?=
 =?utf-8?Q?AbxmcYZBnGfdD6/90SSxVpEaLStuwapSYDano=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009)(7416009)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1VsKy9VL2ErRHcrTjZQWDVyRmF5QWdhM3lBWmpmOTZWb1F3Yi9LOGtrWjBj?=
 =?utf-8?B?ejkydmJUS1hLUTJNMXhpRU5SaEluTFpDVXA3VFprY01CTm9qWHo5Rkh3aGND?=
 =?utf-8?B?YjdQZ0I0VnI4cFBYOUduNjdKRk9ZYnlucFRrZzY5eE9ydjFPRFJ4d2ZmODUz?=
 =?utf-8?B?UTRaTEJORjFwZ2ptUStvdmZMQUJjb0ZCWVRQRWtnM1BWUlA2Y2xIRnJsQWRw?=
 =?utf-8?B?cm1zWmZYSkRuSTVnQmpXbFhud1RvRVNsYXg0ZmJrR2ZidXBUeERNREwyNnAy?=
 =?utf-8?B?YVFXWnBVbDh2M3hLS0NRNEpvd1Bwa0MyeW5EdVYxd2F6UnVYdituUzg3QUdQ?=
 =?utf-8?B?STdNazVqUnRmbGcrRXh6aXo2dXVnMTRHaWhQRkhwQ2paS0pKRjhHNHk4SHlp?=
 =?utf-8?B?cmlrZTVLWEd2VGd3RmpKaXVYYkpneUU2eHRiRm9MK1Bid0hTWW5EU243U0Vq?=
 =?utf-8?B?VGJ6ZlBLZExjdkFMTG5IODZLdTNFQys1cks1S052V3MrZWdCbldYWXJvOVpD?=
 =?utf-8?B?RDFlMmtmTHl5eEtYU2lodGtyeW5pMWFRSS9PaVI1TVpudUVZdjBvd3pQbFBk?=
 =?utf-8?B?QVZ1MFNLZHRhWEJBNWJFUEpFYlk2cXFXNDBiMnRtUFZzc0E4SGNtc000dUly?=
 =?utf-8?B?dXFpUm5LczFlaitNVjJQcFc0NmkzdVpBdVRUdERWYkxNZjJjeXcyOVFGZzlJ?=
 =?utf-8?B?ZmI3UVlwTzE0ZS96clFWcnJobnVXYTIvbmtZd1B6NmNRNDdLOEVKY0l3YS9L?=
 =?utf-8?B?SWtJd0MvNFB6a0gzTHRzL09Na2pUS1NldUxOc1NWZ1loTFhQb0wyQTlxOUNa?=
 =?utf-8?B?VC9mMkR0eTliSnZReWtuRElHRlM3bkY2eWdQTk1GajNDWkNRc2VnUFFhVHZa?=
 =?utf-8?B?bXBkeitCUkM0cWFUZ1pheGxvM1hRYzVTclhRSWFFRnF1R2FKZFhFVkJjYXUz?=
 =?utf-8?B?T0ZjcWI5RGMreEZMc1ZpRFp3YVpJL0ZoSGVjN3I5NmJraWRSQzEweXd4OTFl?=
 =?utf-8?B?RmhEQjFWTFgrejh5UGZZTGlWQ011a1NOMHVpUVh0TzBhaVhCR0N3RER0R2dm?=
 =?utf-8?B?K1pXam1CMWx4dmtBS1pjMXgxUXdWYkt0NGZCaytmMk1TYnhCUnNuaEIvTjZr?=
 =?utf-8?B?ODRRMU1BWHRtUnJWSFkwZGZid3R0K3kzTm5QOHpMYlJFcWNxQk54TUMrcnov?=
 =?utf-8?B?T3hvYTlDUDJuT2VxZ3FqRHh4WXN0OWN6b3BTRW5paDlmR1BTYW0yT3VyampK?=
 =?utf-8?B?K0NKRVpiMlVsei8xTFdjdExyZFd4ODk1N3J4d3Y4eDdUbXAyaHJJTEtka1pR?=
 =?utf-8?B?TjFUZEJCUmR5UUpRY3B6ZlpSb2YvTDRvb0xETXhLRTFWZzcwRUErRE1uK2tm?=
 =?utf-8?B?TFF4R2NBT1EySFBZWGVnR3FXdDlkUklTaUtHTHBLMitMcGNQQm9McVhWMFhO?=
 =?utf-8?B?Zlh6RHNjdmpHaGlYeC9hV2VXZDQzQkMwOUplQzVtaWZaM0ZOMWhIbFQraHh5?=
 =?utf-8?B?U3VLNWltZXp3UmRoYnN4RVZ0c1ZDUDRONS9weWthVDlWb1hXcmF0blBmbk91?=
 =?utf-8?B?elhLeXFTckpNYTh6R1ZFM01meWxQU1BmR3V6K2J3dElSZElGY3dWWVZwVnli?=
 =?utf-8?B?RFh2U2tXcUsrV0h2eWpSMGRJL0RtMjI5OFBVdUFhUmFCWFljM25MTVhKRXE0?=
 =?utf-8?B?b2QweE5xc2hJMWN1UTNTaVkzbSs2NS96K0F3Qkp1YlpzZDE4ODFPU3N2UUNZ?=
 =?utf-8?B?NnNOYXU5Zy9xVGFrQjVMcmp5amhRcU52R3cvOHBVbUEvWFJ1Q0RVYTBXTnl1?=
 =?utf-8?B?cGUwdEZ0Ylg0clBjaURyeng3QURNR1kwWmliSlZHbzF1TElVZFUzcHVSNVND?=
 =?utf-8?B?ZWl1cUJrM1FLS2xPVk5rOWFaTTBUQWRJL1UwcFY4cEcxQkNsOWsyUGYwSHBK?=
 =?utf-8?B?ejB1Q21vVEU0Y1l3Tm13NWdPd0l6enUydEIrVjY5YS9FRGpEaDBmTUFyVUZZ?=
 =?utf-8?B?RE9meXdEK3orMnRKUTNYeEM0cUNpSG0vNlpkZXJoUU9VSFB0aS93SmdyZHlx?=
 =?utf-8?B?NE12WG80SUdnQTR6dTVQay9EOHRrOWg3dTJuYUZoZ0dyUEgzeVJMRTRNN1RB?=
 =?utf-8?Q?U2pYBTa9olGrXDoGs/JAZz4al?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A41332CFBCD4D45B59FAE2906E0EBAA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd18192d-afaa-48de-11ab-08dc8c35cd86
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 05:49:48.8485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H0umY/mxfcxRLY4lI+C0UyEcSroJK4L840jX67l++mG7OcFeCPTTQOyulH3e5hGsK8QMDy2qGWf0QHLJYPjPAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7318

SGksIFNoYXduOg0KDQpPbiBGcmksIDIwMjQtMDYtMTQgYXQgMTA6NDYgKzA4MDAsIFNoYXduIFN1
bmcgd3JvdGU6DQo+IEZyb206IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsu
Y29tPg0KPiANCj4gU3VwcG9ydCAiUHJlLW11bHRpcGxpZWQiIGFscGhhIGJsZW5kaW5nIG1vZGUg
b24gaW4gT1ZMLg0KPiBCZWZvcmUgdGhpcyBwYXRjaCwgb25seSB0aGUgImNvdmVyYWdlIiBtb2Rl
IGlzIHN1cHBvcnRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhzaWFvIENoaWVuIFN1bmcgPHNo
YXduLnN1bmdAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZGlzcF9vdmwuYyB8IDQyICsrKysrKysrKysrKysrKysrKysrLS0tLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYyBiL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiBpbmRleCA2NTY3ODA2Y2Y0ZTIuLjQ3
ZDBiMDM5YTYxNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
aXNwX292bC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwu
Yw0KPiBAQCAtNTIsOCArNTIsMTIgQEANCj4gICNkZWZpbmUgR01DX1RIUkVTSE9MRF9ISUdICSgo
MSA8PCBHTUNfVEhSRVNIT0xEX0JJVFMpIC8gNCkNCj4gICNkZWZpbmUgR01DX1RIUkVTSE9MRF9M
T1cJKCgxIDw8IEdNQ19USFJFU0hPTERfQklUUykgLyA4KQ0KPiAgDQo+ICsjZGVmaW5lIE9WTF9D
T05fQ0xSRk1UX01BTglCSVQoMjMpDQo+ICAjZGVmaW5lIE9WTF9DT05fQllURV9TV0FQCUJJVCgy
NCkNCj4gLSNkZWZpbmUgT1ZMX0NPTl9NVFhfWVVWX1RPX1JHQgkoNiA8PCAxNikNCj4gKw0KPiAr
LyogT1ZMX0NPTl9SR0JfU1dBUCB3b3JrcyBvbmx5IGlmIE9WTF9DT05fQ0xSRk1UX01BTiBpcyBl
bmFibGVkICovDQo+ICsjZGVmaW5lIE9WTF9DT05fUkdCX1NXQVAJQklUKDI1KQ0KPiArDQo+ICAj
ZGVmaW5lIE9WTF9DT05fQ0xSRk1UX1JHQgkoMSA8PCAxMikNCj4gICNkZWZpbmUgT1ZMX0NPTl9D
TFJGTVRfQVJHQjg4ODgJKDIgPDwgMTIpDQo+ICAjZGVmaW5lIE9WTF9DT05fQ0xSRk1UX1JHQkE4
ODg4CSgzIDw8IDEyKQ0KPiBAQCAtNjEsNiArNjUsMTEgQEANCj4gICNkZWZpbmUgT1ZMX0NPTl9D
TFJGTVRfQkdSQTg4ODgJKE9WTF9DT05fQ0xSRk1UX0FSR0I4ODg4IHwgT1ZMX0NPTl9CWVRFX1NX
QVApDQo+ICAjZGVmaW5lIE9WTF9DT05fQ0xSRk1UX1VZVlkJKDQgPDwgMTIpDQo+ICAjZGVmaW5l
IE9WTF9DT05fQ0xSRk1UX1lVWVYJKDUgPDwgMTIpDQo+ICsjZGVmaW5lIE9WTF9DT05fTVRYX1lV
Vl9UT19SR0IJKDYgPDwgMTYpDQo+ICsjZGVmaW5lIE9WTF9DT05fQ0xSRk1UX1BBUkdCODg4OCAo
KDMgPDwgMTIpIHwgT1ZMX0NPTl9DTFJGTVRfTUFOKQ0KPiArI2RlZmluZSBPVkxfQ09OX0NMUkZN
VF9QQUJHUjg4ODggKE9WTF9DT05fQ0xSRk1UX1BBUkdCODg4OCB8IE9WTF9DT05fUkdCX1NXQVAp
DQo+ICsjZGVmaW5lIE9WTF9DT05fQ0xSRk1UX1BCR1JBODg4OCAoT1ZMX0NPTl9DTFJGTVRfUEFS
R0I4ODg4IHwgT1ZMX0NPTl9CWVRFX1NXQVApDQo+ICsjZGVmaW5lIE9WTF9DT05fQ0xSRk1UX1BS
R0JBODg4OCAoT1ZMX0NPTl9DTFJGTVRfUEFCR1I4ODg4IHwgT1ZMX0NPTl9CWVRFX1NXQVApDQo+
ICAjZGVmaW5lIE9WTF9DT05fQ0xSRk1UX1JHQjU2NShvdmwpCSgob3ZsKS0+ZGF0YS0+Zm10X3Jn
YjU2NV9pc18wID8gXA0KPiAgCQkJCQkwIDogT1ZMX0NPTl9DTFJGTVRfUkdCKQ0KPiAgI2RlZmlu
ZSBPVkxfQ09OX0NMUkZNVF9SR0I4ODgob3ZsKQkoKG92bCktPmRhdGEtPmZtdF9yZ2I1NjVfaXNf
MCA/IFwNCj4gQEAgLTc0LDYgKzgzLDggQEANCj4gICNkZWZpbmUJT1ZMX0NPTl9WSVJUX0ZMSVAJ
QklUKDkpDQo+ICAjZGVmaW5lCU9WTF9DT05fSE9SWl9GTElQCUJJVCgxMCkNCj4gIA0KPiANCg0K
W3NuaXBdDQoNCj4gIA0KPiAtc3RhdGljIHVuc2lnbmVkIGludCBvdmxfZm10X2NvbnZlcnQoc3Ry
dWN0IG10a19kaXNwX292bCAqb3ZsLCB1bnNpZ25lZCBpbnQgZm10KQ0KPiArc3RhdGljIHVuc2ln
bmVkIGludCBvdmxfZm10X2NvbnZlcnQoc3RydWN0IG10a19kaXNwX292bCAqb3ZsLCB1bnNpZ25l
ZCBpbnQgZm10LA0KPiArCQkJCSAgICB1bnNpZ25lZCBpbnQgYmxlbmRfbW9kZSkNCj4gIHsNCj4g
IAkvKiBUaGUgcmV0dXJuIHZhbHVlIGluIHN3aXRjaCAiTUVNX01PREVfSU5QVVRfRk9STUFUX1hY
WCINCj4gIAkgKiBpcyBkZWZpbmVkIGluIG1lZGlhdGVrIEhXIGRhdGEgc2hlZXQuDQo+IEBAIC0z
OTUsMjIgKzQxMywzMCBAQCBzdGF0aWMgdW5zaWduZWQgaW50IG92bF9mbXRfY29udmVydChzdHJ1
Y3QgbXRrX2Rpc3Bfb3ZsICpvdmwsIHVuc2lnbmVkIGludCBmbXQpDQo+ICAJY2FzZSBEUk1fRk9S
TUFUX1JHQkE4ODg4Og0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9SR0JYMTAxMDEwMjoNCj4gIAljYXNl
IERSTV9GT1JNQVRfUkdCQTEwMTAxMDI6DQo+IC0JCXJldHVybiBPVkxfQ09OX0NMUkZNVF9SR0JB
ODg4ODsNCj4gKwkJcmV0dXJuIGJsZW5kX21vZGUgPT0gRFJNX01PREVfQkxFTkRfQ09WRVJBR0Ug
Pw0KPiArCQkgICAgICAgT1ZMX0NPTl9DTFJGTVRfUkdCQTg4ODggOg0KPiArCQkgICAgICAgT1ZM
X0NPTl9DTFJGTVRfUFJHQkE4ODg4Ow0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9CR1JYODg4ODoNCj4g
IAljYXNlIERSTV9GT1JNQVRfQkdSQTg4ODg6DQo+ICAJY2FzZSBEUk1fRk9STUFUX0JHUlgxMDEw
MTAyOg0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9CR1JBMTAxMDEwMjoNCj4gLQkJcmV0dXJuIE9WTF9D
T05fQ0xSRk1UX0JHUkE4ODg4Ow0KPiArCQlyZXR1cm4gYmxlbmRfbW9kZSA9PSBEUk1fTU9ERV9C
TEVORF9DT1ZFUkFHRSA/DQo+ICsJCSAgICAgICBPVkxfQ09OX0NMUkZNVF9CR1JBODg4OCA6DQo+
ICsJCSAgICAgICBPVkxfQ09OX0NMUkZNVF9QQkdSQTg4ODg7DQo+ICAJY2FzZSBEUk1fRk9STUFU
X1hSR0I4ODg4Og0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9BUkdCODg4ODoNCj4gIAljYXNlIERSTV9G
T1JNQVRfWFJHQjIxMDEwMTA6DQo+ICAJY2FzZSBEUk1fRk9STUFUX0FSR0IyMTAxMDEwOg0KPiAt
CQlyZXR1cm4gT1ZMX0NPTl9DTFJGTVRfQVJHQjg4ODg7DQo+ICsJCXJldHVybiBibGVuZF9tb2Rl
ID09IERSTV9NT0RFX0JMRU5EX0NPVkVSQUdFID8NCj4gKwkJICAgICAgIE9WTF9DT05fQ0xSRk1U
X0FSR0I4ODg4IDoNCj4gKwkJICAgICAgIE9WTF9DT05fQ0xSRk1UX1BBUkdCODg4ODsNCj4gIAlj
YXNlIERSTV9GT1JNQVRfWEJHUjg4ODg6DQo+ICAJY2FzZSBEUk1fRk9STUFUX0FCR1I4ODg4Og0K
PiAgCWNhc2UgRFJNX0ZPUk1BVF9YQkdSMjEwMTAxMDoNCj4gIAljYXNlIERSTV9GT1JNQVRfQUJH
UjIxMDEwMTA6DQo+IC0JCXJldHVybiBPVkxfQ09OX0NMUkZNVF9BQkdSODg4ODsNCj4gKwkJcmV0
dXJuIGJsZW5kX21vZGUgPT0gRFJNX01PREVfQkxFTkRfQ09WRVJBR0UgPw0KPiArCQkgICAgICAg
T1ZMX0NPTl9DTFJGTVRfQUJHUjg4ODggOg0KPiArCQkgICAgICAgT1ZMX0NPTl9DTFJGTVRfUEFC
R1I4ODg4Ow0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9VWVZZOg0KPiAgCQlyZXR1cm4gT1ZMX0NPTl9D
TFJGTVRfVVlWWSB8IE9WTF9DT05fTVRYX1lVVl9UT19SR0I7DQo+ICAJY2FzZSBEUk1fRk9STUFU
X1lVWVY6DQo+IEBAIC00NTAsNyArNDc2LDcgQEAgdm9pZCBtdGtfb3ZsX2xheWVyX2NvbmZpZyhz
dHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBpZHgsDQo+ICAJCXJldHVybjsNCj4gIAl9
DQo+ICANCj4gLQljb24gPSBvdmxfZm10X2NvbnZlcnQob3ZsLCBmbXQpOw0KPiArCWNvbiA9IG92
bF9mbXRfY29udmVydChvdmwsIGZtdCwgYmxlbmRfbW9kZSk7DQoNClRoZSBzaW1wbGUgd2F5IGlz
DQoNCmNvbiB8PSBibGVuZF9tb2RlID09IERSTV9NT0RFX0JMRU5EX1BSRU1VTFRJID8gT1ZMX0NP
Tl9DTFJGTVRfTUFOIDogMDsNCg0KUmVnYXJkcywNCkNLDQoNCg0KPiAgCWlmIChzdGF0ZS0+YmFz
ZS5mYikgew0KPiAgCQljb24gfD0gT1ZMX0NPTl9BRU47DQo+ICAJCWNvbiB8PSBzdGF0ZS0+YmFz
ZS5hbHBoYSAmIE9WTF9DT05fQUxQSEE7DQo=

