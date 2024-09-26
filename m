Return-Path: <linux-kernel+bounces-340251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2D5987085
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B2D1F294F3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9C81ACE0D;
	Thu, 26 Sep 2024 09:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="q9Y6mUT2";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="PgIGOX+8"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC5A1ACE0B
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343755; cv=fail; b=Xo+0m0P8QE9kUFhCAk/yCk8d2uy+JVloOwYTpoMIgg8Xs7gT0l73/xelcbkVbXLkO+ODWAD3NR/T/vZokogmTCQRxftvxB0uaHewsaGe3mNZkn92jTNdUWkPyCAeHdRtrI8mcxb4xTQmqA/lQqh+cvRnvoYXoYCKdU+rC+N3aA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343755; c=relaxed/simple;
	bh=xvzMztFWKHZslNBRqItGrcFfHZNpvAtsKBU7WFTSfVk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PATtdu0OR6B+HN1+H1mnvpz+UvbHmXROdMFR4S30Xlt0Qhvj9HMBv6VxBJE3m6Lgdqspixsp2x1E6pq0oOpueFYf/VK2fraOvqEv9zV20rlIZbxDWeo5yayxvlP3/zwdDyC3Vhn91wu5TaP4I54n/Dyjfls/dKBnIOxh6x+QTMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=q9Y6mUT2; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=PgIGOX+8; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a42906b07beb11ef8b96093e013ec31c-20240926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=xvzMztFWKHZslNBRqItGrcFfHZNpvAtsKBU7WFTSfVk=;
	b=q9Y6mUT2XcNAU4ozZbCyiPF652GIuIIuT7p+WoQW0qVW6dPJOCAEYg3gdpOUfpRVDSuHDS9eozzawFKiIhXFv4FfO59n29HXniYMr18sx+YxbMzqTQyDRuJJSjs8OkguJb3L320salXNCu54YC+LMxpNft7OVr+fSS8SpRhYSck=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:d416bc23-6918-4679-bf21-4592d55778eb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:6be9cdd0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a42906b07beb11ef8b96093e013ec31c-20240926
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2016748592; Thu, 26 Sep 2024 17:42:27 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 26 Sep 2024 17:42:26 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 26 Sep 2024 17:42:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=My0THmY9CCSKXGNh3a6jQwk3TGuNuJLeuifx2l4aWiU1A+49l8BvTz6fBJr23da9gHq5+VXY/e7GYOug8UU5XeVEhSUNLiA2Orvr8+T/FbYmvuk2wmpCzTKaf+20SB2vWhPAM1Qn5ehR48JtO6fYPpiOv31hwRfNFOe/jjWH9TMwSi3Vhm5N28UdrAKQ6BV01fN9ZCPQB+F7uwN325v4lWatZUh+nOit7mstNoolQIYm2zrKCmR0fAnMqvWHUvVicPvNEB0M+oW1G6Ya4XuMT9knOC6uOudzCwEDVobO5J/dWKwn/B6Cbd7ubso1hUzfsvqmzQZEePsmqgom2CRX8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvzMztFWKHZslNBRqItGrcFfHZNpvAtsKBU7WFTSfVk=;
 b=DAqpNKE2wtIxHGUlSkEHpRGJeTxgZ9RNFAMixfV3PszLGZ03zeLkH1vN9JIvufbJbWM8flyeoSfighNwnJJ0iqlAvIrX5Fzxn2gttH1ltoM+OyWnxCQcH1/UBpBRIv+1Z8jNTgPA749G+Q88JGXcnTRQAfrRsfChL+inICrUx4MXWrPyvAY38kryzjDtdb9V6p32/cMyV6EgOmQhsPMOawpL8ZeJhN01ZIgSSf8VjQDUVoH6N9UwgtuZ2Q7GUFVJ8bW0J+1FOdejeXwVGrbDWHkjML0lSFubpt4cgVB6TOnvZwXQHkP1YkC3EWHz2usRWi05ffXYufQ92YaMS8hEQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvzMztFWKHZslNBRqItGrcFfHZNpvAtsKBU7WFTSfVk=;
 b=PgIGOX+8dRezkbqjWIPAXSPU0DxAoscoU5RSv/5ray8P8JsoWWv6EwkbBY7erYLBzWJVSb7qeuqBwPZfvmxs1dvegltxunTnXPvfYS6dorixBk8zZ4hwh0CkkJygSM4F7TRe5v/6XHCZ1qCFDcnOxQyjOO+CbpCuSwxSYwSCKv4=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEYPR03MB6507.apcprd03.prod.outlook.com (2603:1096:101:54::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Thu, 26 Sep
 2024 09:42:23 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.7939.022; Thu, 26 Sep 2024
 09:42:23 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>, "AngeloGioacchino
 Del Regno" <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 2/2] drm/mediatek: Add blend_modes to mtk_plane_init()
 for different SoCs
Thread-Topic: [PATCH v5 2/2] drm/mediatek: Add blend_modes to mtk_plane_init()
 for different SoCs
Thread-Index: AQHbDzSM3Xaxo+lrgUeyI7cbZNI16LJpwEMAgAASGIA=
Date: Thu, 26 Sep 2024 09:42:22 +0000
Message-ID: <2c05e5d9684aac50dea22c2c0dfbf0f679e29434.camel@mediatek.com>
References: <20240925101927.17042-1-jason-jh.lin@mediatek.com>
	 <20240925101927.17042-3-jason-jh.lin@mediatek.com>
	 <64b96ec0-1264-4a3c-a26d-f8a0c3375d79@collabora.com>
In-Reply-To: <64b96ec0-1264-4a3c-a26d-f8a0c3375d79@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEYPR03MB6507:EE_
x-ms-office365-filtering-correlation-id: 899b9363-aea0-415e-f705-08dcde0f85c5
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WUFva2J3SWZWSFE5SEJ2STgyZGtRWlF6K3ZKSEdHMC90QnVjRE04MVpNZitN?=
 =?utf-8?B?YnhtUFgwd3Q1dUxYaW5TeGZrbk02NXZCMnE5UkVhSy95S2k0TUpTMkR3T29M?=
 =?utf-8?B?MUQ2bHAxM2dxSVBqcWwwZ2xETml4M2t3c1BqYm5TYW52bDA1aGhzOGNpYlps?=
 =?utf-8?B?L0lkQk1OU3M4eXFZYlRSSU9odDRLK0RpdGVRTGFGMjJjcHFzUkk0akhGUzZX?=
 =?utf-8?B?Ui8xUEFTOGdCZG9RWTVWUUxHRUljR1hlc09scW84bGhpOWxOeWQ0eGFIVnh4?=
 =?utf-8?B?T2wwMlhKNi9kNFMxWHlvQktkV0Jqd094bm0wNXE5MUhmRklxcHZOYmRvWlZv?=
 =?utf-8?B?dm1XMkZETDBheXIzZ3pXYmd0KzlCc3NWV1FwR0toYTBIV0o0RDdGKzZLbHR3?=
 =?utf-8?B?L0ZlNnU0SlBRN0FnUTZSZHhEYUxITk5LRnN5N0QvM2NNV0p1ekNqZEtyTlNV?=
 =?utf-8?B?Y0ZwWEJMZzQwaWtCVXdhbitabUZUbDhrYXpmbktiN0NUeUNBYVJ5SjZUY1Ny?=
 =?utf-8?B?UEdCWWVoZmk0V2hMZDlVeHd6RmVUdTRBNXNHWExtZVg2dDBDU1dmSXR0bEM0?=
 =?utf-8?B?amNJVXVYamhnR2phVk11K3JGRTV6ZmRlL3FZVytyWk11ZGxFZ1lRN3dHdzY0?=
 =?utf-8?B?RFNGUlRZUGYxajZBdG02MGVIME84dk9ZR0k1WFZQTTlZU3BpTkcza3RtejBJ?=
 =?utf-8?B?TThKR2MveVgreFNGMk5sUlRNaGtPaC8renU1dEhPeVNYQkZOTzExLzJVKzAz?=
 =?utf-8?B?MHAwZjhhY01QYTFpa09OSW03OXY2NTc2VFpaM0Y3b1V2WG84YlJZTUtxVDRw?=
 =?utf-8?B?OFdUWko2YUVITXBxVWNBczVIVlpwWHZ6cVVsUytHQXg2ODhPU21NWVZBS1dr?=
 =?utf-8?B?ZDRrYVJCRExpdDNOdkxUUGJWbGhNcjg5QzlQUWpndHdlVWZMR0M2Y3QyeVpW?=
 =?utf-8?B?NkpjZEhqMkZZTUZ3SHUyMFZRVU9vNmlYQk5QZE5kYjZKMndlZTNUVXYwUzY3?=
 =?utf-8?B?SHpLSkZXa2pFbVZDUXFtU0pEcElKd2ZSYkR5eFFycEMwaXRQS0l0UmhQRHlk?=
 =?utf-8?B?OVY2SXUrY3Y3N29CaE14L2xYVHlISkc3VUZ2WUloVmtJdTlZZVlXOS84ZHpN?=
 =?utf-8?B?OHhaM2RlWVJDT1kzVmRocHpDVk1NUXd6WkxVemVYalIyUkVQTVVtNDNlSzRN?=
 =?utf-8?B?aEFJUkxCNllraGFKekdzZ3JudURSaUp1T0FDdi8zN3lwaG55ZCtPTXNPb0Fy?=
 =?utf-8?B?em5iU3ZDYnA1aUE1U1FTV1kvMnEvMVpGMGpid05MY3NTeStYTUVteUo1N0xH?=
 =?utf-8?B?THc0NENicllFR0N2c25NdXN0ZUpBMFF5VW42bGhIYkpyN0pKTm9aTlM1b0tm?=
 =?utf-8?B?TllvK3h5MVUvdEZLWDhxb3FLdWJncnNYR05IMURqcnJBR3VVTjk5OVZRQnhE?=
 =?utf-8?B?RDNKdTBJMXNjZVhCRkRwcHNHeFBRQ2g2d2dIb1pSNWRmdWZVL3JWdnRoRC9X?=
 =?utf-8?B?d1k3dnZvbU5ZbEJDRGgzUE5TRTA3WHUrZ0NHT2JLR3U0eTI4NGxzdjZQUjRh?=
 =?utf-8?B?bzNFY2ppUkhpUERPZDRXRW8zRFJ1UStiZ0ZmMnVsaE1RbUJ0bFFMTUtRT2sx?=
 =?utf-8?B?KzFQOWNDWVNTSDRIUXY5UHhQaHB4TnJVTnBTK243Uk13a3UwZnVlVERZbTVV?=
 =?utf-8?B?TXNuOFBDZG9SVGFyeXJMc2x6R0ZOcjVxT05ZUzczTE5Vb1FwM2l6blhoWWlN?=
 =?utf-8?B?RGlnTXBrbFdsMm44c3dZT1picExKSW1yb2hGSEVDQlBSSU43MnFVL0VBWTJ2?=
 =?utf-8?B?RXQvQWpoTFh0QzltdWdhQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGxhUWJES3cyaG1XemZuVmx0eGRTdEFMZ2xoeXZiQTdWSlI5TjJuYnUrVWhq?=
 =?utf-8?B?UytudGNSNUNvdmZCV1RiTUxseGFuS1VMUXpxK0hKRHFqTEthRzgxQjRFS1dZ?=
 =?utf-8?B?QzRDMXI4NCtRNkxUZVhLZ1IzTjYvTDdqMy9ySnBzTDhzM0FoemEwb3IzSXUy?=
 =?utf-8?B?eVZjZ0FoWWQ3SnVVbk0yYVFtTjU5ZmthcERkNWxQempmd0lZRWF4Z1h0c3NK?=
 =?utf-8?B?bmFIbjdzL2lMMHpRN2xEUVFJVzl6eVN4cGVaT2cxMWJ6U0phNzVoRS8xNk5Q?=
 =?utf-8?B?NWFzem85NGtMVUVMdVJDNVZGWkp3T2YrK3RLcTBRbE45T3QrQ0RzOFhtQVA2?=
 =?utf-8?B?aGhJSzhER3p2REFISW5wcXdEZ0NHRTVMdnBvRmYvdmxUeThEUFhUOGJzbCtI?=
 =?utf-8?B?NHkyRUNidUVFSnRBUXdTcTFLUFJRU2U1a01QdWM4aG1mRTBMTmgxeExvaWlI?=
 =?utf-8?B?QkZEbks5ZWNWSDIrYnJ6ZFR1eWVNVmh1aXl3bE03MFozeHVJL0g5K3E0MWFq?=
 =?utf-8?B?dDNsN2UrbGRNZTdaTWdrRDZ0dXBwK2I3ZnhwYloyTzdrUlMyWEhKL1lCNjhW?=
 =?utf-8?B?WloxR2grdm5ocGl6bDAzYTYvQ0Vybk1FdFFkby8zYm5EK3MyVDd2aTBBUUt2?=
 =?utf-8?B?NmJPT0FQZE5TbUZlcy95N3A3Vzc3ajJ5NHNlQWtKaStHYWlEbi9ZSUNZZ1BG?=
 =?utf-8?B?Skh3M0M0RXd3V2FPb3l0YmxsNmZ2ZEFtdENVUkNLUUgzWnpHenBSMnVXdkVm?=
 =?utf-8?B?RGFIcVk1c3o2SFpYZEdQZ1MrSHdIeENKSDhPZHJLTzBZNWlWTm1CdFVTS0c3?=
 =?utf-8?B?a1pZYjNxMXNmUHk0bmlMaDNkVXlTSDJkcTJ6UjNYTGk2K2FEMGZaWnZMVmdC?=
 =?utf-8?B?c3lWckd3bHpqVysyMlVEalFDWnVKR2VieTE3aFJQTGhoZi9yMGJlNlhNZ3l2?=
 =?utf-8?B?TDlTWGU2RFNodTVjWkdVTmdwdUhwMjE3SmNqc2xaOXRJR21PemJwOUFEb1p3?=
 =?utf-8?B?YUFhQnhmck93VTB1L3NwZ0ovemQ3YkliRmhEdlNZbFI4WlhaRTU3REh6eVhY?=
 =?utf-8?B?WDgwSTNBVjdycWhBQ3ZsMUdIRGpLNzFJSVFuZ25pS2QxYTJBb1J5U1IyMHRD?=
 =?utf-8?B?a3kvYzk1aFVJMlU3b0VDRjB6QU1ja0h6N2syOHVSSzA2bzdUUEUvZXMyTTRR?=
 =?utf-8?B?eVk2dVBYVlkzYzFEVUFSM1BuRmpnVEg5MURZa05CUEF0NTNhK1luaXNpQTEv?=
 =?utf-8?B?R3VPb3lpZm80MkZvdWpXb2hSVEhLazRjK1VDRjFPVlVsYkJHOWxoeTZLS1Zm?=
 =?utf-8?B?blhBVkdjdlpLc1VrcGxJMGcrbnlGRkR1YWVnaW94eDYyc1BxY2dSS0ZNODVr?=
 =?utf-8?B?OU1TK3F0UDdZa3EreUNRcWNsZlYvSlhPazZSWkVPak92NmJ6WEtRcmhvSklB?=
 =?utf-8?B?dWh1R253U2JjSFBoT0wvazA5cW1idjYvOUYyRFYyaXZ4NmE2b1pHVXBHdzYz?=
 =?utf-8?B?eFAxcXZyYy9rZmdLYlNiTFhUVWxScFNyZ3hYTS9wR0tndnlUZmF1bjloL1pM?=
 =?utf-8?B?S29oclJxQ3E2VVZvMXVkZzN6Zkh0Wmw3TFQ0U2lGM1h5ZmEwY3h3TkZUNllE?=
 =?utf-8?B?QjNUTmRaWjB4WFdYMXBzYzhFaldrQkloSGlrUS9GUFl3TDIya3JuMGprdlMx?=
 =?utf-8?B?djlqZTNWNThjQmI0WnE5SFFJTW9YSVNSM05QZE4vVDhnNjNFbC9hNmhGWUlF?=
 =?utf-8?B?NG1GRlBPeWF3Z0hsOThrb29SQVVETlk1bGhEOTZKQUQ4NTQ4dDBsVFRLbEFi?=
 =?utf-8?B?NXRpQTRYNFQ4MnBUWkFYdTlCTDUxS2s2c1dUbzU5dEFuMFE0eU9FclJEYzd2?=
 =?utf-8?B?bm84cWJic0NRRVQ4Z1RoTkF5WnVhRk16Q3k2Unp6YTdONHAxWS9Pb3A4dW00?=
 =?utf-8?B?UXMvQTFkQWUxQW40bUU3bFBvazAvcmZaNmhBM0k1Y3c1TTQ1UFc4ODdVOGwv?=
 =?utf-8?B?RW5GZTh1OHczdGh3UDJCdzg3ZnVGT1pLaU9vTm4rRHdWd0RXeitxMXZEWndh?=
 =?utf-8?B?MFF5bzNlNEZNcEVtZUdBUjZvT1M2ZkxGTFlObytYbFdmNjhtb0hYYlFxc0NE?=
 =?utf-8?B?WmlaWXNpNVZRY2h2OTM5dUNGSVVYdzRNcXZjODFqWDRMMGdlRGNjc0JqS0tx?=
 =?utf-8?B?Smc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3A232BE66CC8744999FE0565FDF5F02@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 899b9363-aea0-415e-f705-08dcde0f85c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 09:42:22.9433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JtlfeQuVcSqpQTPzW0tIHJYlTUEfSmAH+Pj/TgwpOGCkOrKvqtGlNtU9+o0E3gpX7G9mrNPoD1+iPrGtiPYvGzS5FwZ/EI54wwEIwB3mb1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6507

T24gVGh1LCAyMDI0LTA5LTI2IGF0IDEwOjM3ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjUvMDkvMjQgMTI6MTksIEphc29uLUpILkxpbiBoYSBzY3JpdHRv
Og0KPiA+IFNpbmNlIHNvbWUgU29DcyBzdXBwb3J0IHByZW11bHRpcGxpZWQgcGl4ZWwgZm9ybWF0
cyBidXQgc29tZSBkbw0KPiA+IG5vdCwNCj4gPiB0aGUgYmxlbmRfbW9kZXMgcGFyYW1ldGVyIGlz
IGFkZGVkIHRvIG10a19wbGFuZV9pbml0KCksIHdoaWNoIGlzDQo+ID4gb2J0YWluZWQgZnJvbSB0
aGUgbXRrX2RkcF9jb21wX2dldF9ibGVuZF9tb2RlcyBmdW5jdGlvbiBpbXBsZW1lbnRlZA0KPiA+
IGluIGRpZmZlcmVudCBPVkwgY29tcG9uZW50cy4NCj4gPiANCj4gPiBUaGUgT1ZMIGNvbXBvbmVu
dCBjYW4gdXNlIGRyaXZlciBkYXRhIHRvIHNldCB0aGUgYmxlbmQgbW9kZQ0KPiA+IGNhcGFiaWxp
dGllcyBmb3IgZGlmZmVyZW50IFNvQ3MuDQo+ID4gDQo+ID4gRml4ZXM6IDQyMjVkNWQ1ZTc3OSAo
ImRybS9tZWRpYXRlazogU3VwcG9ydCBhbHBoYSBibGVuZGluZyBpbg0KPiA+IGRpc3BsYXkgZHJp
dmVyIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRp
YXRlay5jb20+DQo+IA0KPiBKdXN0IHBlcmZlY3QuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdl
bG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29s
bGFib3JhLmNvbT4NCj4gDQoNCkp1c3QgdG8gY29uZmlybS4gRG8geW91IG1lYW4gcmV2aWV3ZWQt
Ynk/IDopDQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4NCg==

