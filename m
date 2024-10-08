Return-Path: <linux-kernel+bounces-354690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFDB994110
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B8C1C20917
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078B91DE8AF;
	Tue,  8 Oct 2024 07:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kG84JWrT";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="o0U3sNgF"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E24B7DA76;
	Tue,  8 Oct 2024 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373293; cv=fail; b=amROVuughYrBIxKqLZwRLX75tHv4nTy3Vljnud9tNWJDL+uZrK2UCcvQPfVk964uumsUULz8z2o6oXEL50qcmi5jDkJPPx5HW3H5jP9jhpsjU88El5e0h58OYoyuytOnh6yzcr5tyVfsDuluES9hn9xKfvFoh51tpO5VhWHSrss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373293; c=relaxed/simple;
	bh=9OXa52AhcuYzWZ13SO0MqhqDu6oNFt5n7cFOh26ZHC4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ojt1GS7pO3uqyMNuuIsuECdehCd5vgRZzwGzgm3z5D50wGFTJsQvEv1fAHpf1IFL7dLIwvouBRow6HRDEDvbG75UHk+wqnHaffkweTArtrHSdHHgQpC+iaGFCFo2KBopecpd+g3Pzyrpu5NlUIESan+cxFCVSHnuFyR/CzLRf24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kG84JWrT; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=o0U3sNgF; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b6ae1620854811ef88ecadb115cee93b-20241008
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=9OXa52AhcuYzWZ13SO0MqhqDu6oNFt5n7cFOh26ZHC4=;
	b=kG84JWrT2F0dGfx5nKYzSCzEa6Jt6MKNq2TXivF0ZRf8k55pzQRsHVatx5JSI7oCZLQN9H95RqWyNoU1mM9PyIH1x3OGfodJUMgy8XlNpomNM1DRK4vbeSzgzSdKw6gqrnr+aBpNSqLc+vNSdeU9Z/0AHbR4fN3Gw3WZZGbO3P0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:e4e72c66-e194-4cc8-9c20-da227b131f58,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:fa3d7626-5902-4533-af4f-d0904aa89b3c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b6ae1620854811ef88ecadb115cee93b-20241008
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1971984969; Tue, 08 Oct 2024 15:41:22 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 8 Oct 2024 00:41:20 -0700
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 8 Oct 2024 15:41:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRPVitauwifkrJq8qE7ai+Qldsi0fiX+ja50Nvh5DUU6o0yMkkZcwljTOFjkofAMwZklEVUhQQumnS0el9O7m5OQqkX5o3BHIeJNNGg+MdikasKz0WLb0222wO6Vz6ApIP45ggCvlsVb7lqSEe2OTCtKf2cHXWrzh0bhosTWbgUkEzGmA7xTicxuP6OmR3KvHDhY3rEwzlfQw+fNGTH0WplRNV1V8Hh3Yg79aVnWOPk4PqjeE4WnvxBHYUoGnDIkp3+OYkkAbbWRFbRVKN2nzAhvm8v+DjeOr390C2Ne+66BuG4lpQcISAAg98iZ9f2TlqYm56EnbA4NhX4J/VMX9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OXa52AhcuYzWZ13SO0MqhqDu6oNFt5n7cFOh26ZHC4=;
 b=oV5rA6fwKR0IYCwM6cQocEtAec3nfudD9FdhdCPXsh76LFCoCcl0SFwo0Xtd9j4Cl9vAAJ8JiBB0qhW1Ik+b1vSSdlGscBW8rkA+6XB2O46kh35GMnhYweD7U/lDkvB1+yvBOSIgF7VCFG7aAp+iWJ67iDKHy7n7lqbN5/XejShwb+F3QF8g+2zYyQye0TofaSoIzb+Dsci0kQef6MIgmMWX53hpfR/VyJ08cXlL5G2j9CVDySp1sc5TbbBDkWn0zmleTrjnP3MRwPk4S0NwDYw9zBHJStuTgVqu1/bUKTh47uC3bxoTjHNnSgEuoscirMEFEy6F2hfWODcPmPZXUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OXa52AhcuYzWZ13SO0MqhqDu6oNFt5n7cFOh26ZHC4=;
 b=o0U3sNgFDYx0NijvCuuWSAFObuIJR+JL1R7mbdrHeneU0eBYf4OPBOeZhcp6TED7F8nk7EyUF6TlduAH8zWD8bsrkqLie9MijyhBmV2pL+fIOXO0RAnadA1B+mbxoru/Xcdyz62CDGlCEhMSE8mt23jqtYAvFElRvWLDtjx2N7o=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB6481.apcprd03.prod.outlook.com (2603:1096:101:51::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 07:41:17 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%7]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 07:41:16 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"sui.jingfeng@linux.dev" <sui.jingfeng@linux.dev>, "wenst@chromium.org"
	<wenst@chromium.org>, Sjoerd Simons <sjoerd@collabora.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"mripard@kernel.org" <mripard@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"michael@walle.cc" <michael@walle.cc>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "robh@kernel.org" <robh@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "kernel@collabora.com"
	<kernel@collabora.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= <Yu-chang.Lee@mediatek.com>,
	"mwalle@kernel.org" <mwalle@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Alexandre Mergnat
	<amergnat@baylibre.com>
Subject: Re: [PATCH v11 3/3] drm/mediatek: Implement OF graphs support for
 display paths
Thread-Topic: [PATCH v11 3/3] drm/mediatek: Implement OF graphs support for
 display paths
Thread-Index: AQHbGJvj29sreDXMGEakTX36fvej8LJ8ebCA
Date: Tue, 8 Oct 2024 07:41:16 +0000
Message-ID: <a7fd78a9fb858552e48339bc4bf3d3423d428f3b.camel@mediatek.com>
References: <20241007093114.35332-1-angelogioacchino.delregno@collabora.com>
	 <20241007093114.35332-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20241007093114.35332-4-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB6481:EE_
x-ms-office365-filtering-correlation-id: 587867b1-c2c9-4a14-5876-08dce76c97ad
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cVhsYjVranVGWEIzQUsyWHZlNGo5SjNzWXlTWHAxbVEvWFBoRlJqY3RMYkVJ?=
 =?utf-8?B?WFExb0VqVm1RMXdTd0N4WllUZzQ1c05lMU0yU09YbzcrS0tzc3dZc28xZDU2?=
 =?utf-8?B?YXQ3Q0ltUDlxU2RjUEljZGNvdXJ3NzgyQ3ExMjJybWVaVkVvckhNV0J5NFZx?=
 =?utf-8?B?UlI4K3lsV0V3Y0ZvemZPa1lIWDhUWTJvRGJZNi8yZVJTRElVRHpYUzI3Z213?=
 =?utf-8?B?d3RIOXE2dkRtN0lhcFFyMk0ycHFXY3IrVmg5WkxOTjVQOW5IOXl0Ly9Ec29H?=
 =?utf-8?B?bjV2azE2aWNCT01VamlCSmQvV0lqT2RKRDhZeWFVSkdjQmJIZHl1RUtBRHJK?=
 =?utf-8?B?alNRdVArK1ZtSDQvODF4czk1c2tpR2o2TXdUNWtWazdDdUxtS1VQL3lLYmpv?=
 =?utf-8?B?eE50OC9pZEdIVU42eXkvOHF3dE5sQW9oRFUwRlB2d0wydGFBU2RXVitRamxm?=
 =?utf-8?B?WW1SZ2JhOElYbTNGS1IrTHVLaE9PaTF0NCtZNXBHVTFrZm9md3puczVHZEM4?=
 =?utf-8?B?b1JjY0U0bWNsK0hxUFZKQ1hRMjdVRkFsb0tCaTVTQTFZYmVPYStBQzRZcVhh?=
 =?utf-8?B?MEFweHpVVHQ0U3REOENoUXZ3UWxXVFZUT1JlWVQ1cmZka2FRV1VuM25Sc3By?=
 =?utf-8?B?cnhMa29HWFVzYTFYV0hOempiZkluK1JNeE93N3FHOGlZN1JSc3pqTWdFNnRN?=
 =?utf-8?B?bmV1RDVPS2hydDk2SnpRM1A0QnRWVEsxWVZhTmhOajZYbG9rVUJ6Lzc3RTNx?=
 =?utf-8?B?d3MrdEZEOWZvUHJKcm1Yd0tTMy9mbUpRYnQ4ejRYOFYrK0tsQWJ3TVN4MVBt?=
 =?utf-8?B?SW94cU1hUWVLaWlZcFRoNDRVNnc1MGxLMnFUdTZPZWZWUHhKQUxqQ3VVVXc3?=
 =?utf-8?B?K290VTJZeDZ4ZENEUjk2dmZVZVhMMmJqcjFpeHg1cHFka2I4WDFuQ3NHYWJR?=
 =?utf-8?B?VzVUU2hSMTIyZFU4VkJRYlRBNHdnSC9jUFlFYzFQWlNrVzY2cmd2blVFL1BS?=
 =?utf-8?B?OXJCMHErbXM1Ymw0KzcrQjFFamFQMUdlbGdTeUFyQ0VZL1NRTm9ESzlvVFJk?=
 =?utf-8?B?RUl5a0hjK0NIVXExR0x4K2E2QnovUEl2aVphR1hQeFBDdWNmWDZWVzNWbmll?=
 =?utf-8?B?aWxyVmV5OC9mRUR4S3Y4MnFOaGY0ZmhvME45T1BHa3FFZ0k4RWJwZ1BUcDFH?=
 =?utf-8?B?Zndyc3JZZ2M5ZXJEamFEZlpHVUxwZ280WWVTUXR4NXZwVEhjRENSR3QwdTFQ?=
 =?utf-8?B?SjBUa0Z4ajVzNkRwYmFLc2JPZndtSmk3Vm9Iellvay85bzV5NFZCaWpRbEdl?=
 =?utf-8?B?eTZFRUJORXRRWlRkd3UzUGNpNGswMk5mSEZwL0RUc1hjL1loaGVJL3JVWHEx?=
 =?utf-8?B?V3A3YUNEN081NGVRdWRxbjVPTko5N3VDMkoxKzcrOUoxT2NlSXNSN3RIeHl2?=
 =?utf-8?B?QVJ6Q0pwOW94bWh5azkxdWJCK0VkRnNFckQ5Q21EYWJydTEyNjBXS2ZuSUx0?=
 =?utf-8?B?Z0duUE84dFNSTSsyR2N2dUJVQXF6MW1sWVFmWWI3Mi85RmNJU1NwQnN0cWJ6?=
 =?utf-8?B?Z2dGK0xZcG1hNWVjM1hGL1o3Tkd1TjJldXVlMUlDK2JRWE1kSi9USGh3TWhW?=
 =?utf-8?B?L1hqRzUyQnVDbStFSFVCQ1Nyd3J1OCtaVmFzREI0L3E4Z2lyeThKa3FZaFlV?=
 =?utf-8?B?SVpicHg1d3V4WXVMYnRGMTVmUUw0eEh2RWNnRnA5ZWlEaUtqTXNwa2ZnbzU2?=
 =?utf-8?B?MjM1eWdBb25jMmNvRVQ2VG5wNUJWUEVqMDRWcGxyaE5IOFczRHNENFpucGk0?=
 =?utf-8?B?cmhncWMxbUhiTGNmbzNJUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enIxZi9HY3hZOENKZXZpWHpHb0t5TG5SbVJwL3QvdTkwazlidUQwTHdZMkw4?=
 =?utf-8?B?NHpwOFF6NjFZS0ZqbnZBR1lWNUlyYWFhMTl4R1Zod3BEMFB5NnJZOUZub0k4?=
 =?utf-8?B?aHBIRUFpRkxmMzRuTnZ0QzlramFHSDdMV1lSNU9WRHZkZWIyUGVMQ3VrTjk5?=
 =?utf-8?B?MmR1M1JJSVUzbDVZOXVTVi9qblVCbno5K2ttYlNqTlNZd3MzdFFWVUFvL3JV?=
 =?utf-8?B?S1VBZGNHVW1LUkhXYUp6bWhMNUZpc3A0cWJzTjNlSWp1VUU0S21JYVRvUGRx?=
 =?utf-8?B?RmkxbkxyUHkvK2FyTzJZRW1HUjJSQ1ZmOG9SSlMvdWdDdG9KdmJTQm5ZaXdT?=
 =?utf-8?B?QXdjSXpKQnBRbmtMYUVkdjd4WG00K09INEM4dTZwSWlDWWdMeVFNTldCYld2?=
 =?utf-8?B?SjJvMUxLak1HU0YzZ2NCc2tYS0xJd1pwQmJBZnUvajhyY2RXbFZyTzJ4S3B2?=
 =?utf-8?B?NDB2UitBMzlsV05HSVF1ek85d1F2TFNBVkNVQTNqRHQ4SmNQaDM2dG1lOW9y?=
 =?utf-8?B?ZXMvNlVVMjhkUlhZYXQ4TG9XTFU2Qkl6SFptS1JIckFOMERVcjhCcFlVU25D?=
 =?utf-8?B?NkdKdy9jR3JCeWJtMldxdXpadlRtMWEvb1paWmEyRTBUakorSGJyWVdjYU9o?=
 =?utf-8?B?NE9iT3grUnR5TnVJWmFQTFZwUjhZS2RSbHZBUEY5WnFIbm9YdTd0cmJGSjlJ?=
 =?utf-8?B?dXdzMlYvSHBvb1N6VTFaWW8vdHhnMWovRm51VlVsZEVCYk44SkF4OXV1Mi9C?=
 =?utf-8?B?cnh6dVN0V2tFWFRFWjBXZTdqY1NVd3pnL0hSaVFGRW5WMVVOcEhDaVZPWng2?=
 =?utf-8?B?Q2UyM1NTOU51cjRBbWRHa0hrUUxmZEZFaWx3V0ROVTRxOVRZOWhsMmdSTzlL?=
 =?utf-8?B?dzZBRERUcmEvTzRMODlHZWlscDZ4cDRuNkpJc2tnSy9WMm5ia0lEQ29la2lQ?=
 =?utf-8?B?bWxQVUNTY3N4MWxJNUVrcE8yNDFGK1IrWm0xQlBXRFYvQU5JbGtocHorKzBw?=
 =?utf-8?B?NkI2empmNTdOMVJTQ2lGY0pLVWUwaU5SUm13eHQ1UlFJQjJnTTgyMGRlaFNT?=
 =?utf-8?B?UmpvSm9NbXp4OHNwalVzbTJJd3FXS0k2dk5wTHVBcGtrak1lMkJGUHRSWCtX?=
 =?utf-8?B?WTR2OU4vZkZtcEZNRW5SWUx4YTd1QkgwQ1l4dllYdzJvMU1NZXVmWlYxKzRI?=
 =?utf-8?B?OFV2WngxVXVhSzRuSktKdEhUdC9pYk1PZUdZQlVaZmNSMkZnbGJlV3duN3VR?=
 =?utf-8?B?UWk0bnd1YnNpTHROdENPeHZXQW5rU3ZoOWhuT1VTa29pZHBoWVQ5WGxIbFhx?=
 =?utf-8?B?SkcyNGhXdTRQajM1bnNIaWZIejRmVVFQRTgzb0I4N3l6aTNTSCsyM01NTVVZ?=
 =?utf-8?B?R2pacCtKMW5jSVkwV2FsUW5yNGJ3d0N5emZIbTFOclpja21IRVE5SDlpZ0Jm?=
 =?utf-8?B?UmtLQlpidE5BS2xmSE5rQXUyYll5M1pQWW05WDNZYmtxUHRIMlByMUMzWExR?=
 =?utf-8?B?aWJlVWRhbW53dE85S296OGdodGhOeE9XbFMvcllJVlpTQnVyN0R2YzU0Tk9k?=
 =?utf-8?B?VU44RHVERWc4T2VQNjFoRHlseCtRQ3FWN1lwcExBdnA1aGdHS2M4UFNpeTFk?=
 =?utf-8?B?bmcyUGovVFNJQTFrcEIyMG1jU0F5UHVWdDRoZnArd2kxZVkxcHpHK3N2cUFX?=
 =?utf-8?B?MU85TnY5emxtM3RMUFBrRXFyNU1QanYwWEw5UzZMNml6N0l3OXFPNGN3R1k0?=
 =?utf-8?B?b1dNV1B2WWZpWm9ZdDAwR1N6WFVzM0xYcHNqWS9wQkZWaEVPRUJWTUptWTcw?=
 =?utf-8?B?SS92ZGRXVjJkMlF2UHRGSWE5M2NlMFFLVFVReFB1T3NqNklTRXRHTzMxN3Ev?=
 =?utf-8?B?dG9EaUpoM1NUUkt5YVhIZEg0TkF5azR1Nkc3c3RKZ1daa09NWE1MZlEzQVdp?=
 =?utf-8?B?U3oza2dua2VyaFNYYVN0MTl2UVBFcmhUZTNuaXBwMmw2cHhVeExQQnd3OVU4?=
 =?utf-8?B?WkhQTDdESEQvTEwwdU5mK29Da1Y5QjZBUFM3TkdSa09vcTg1UTNIS3NjeVpS?=
 =?utf-8?B?bGFwUWtWKzNRSE0rTnFsNFlZeXErQ1h0Tit1endyV2liM01HWnBNaG9nSGYx?=
 =?utf-8?Q?RtyO7EjR7XhC09VCx1LSLkHD6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AF317ACD82D6140885F89E2678A79A9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 587867b1-c2c9-4a14-5876-08dce76c97ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 07:41:16.5934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V6bvWRMiEvELEAagfWI1zwMilJu9EQZEkk2ioWeMon8rLjZMYXNc3OGetOltthbbmI3aOLMl3SQtIPdDzvOZ6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6481

SGksIEFuZ2VsbzoNCg0KT24gTW9uLCAyMDI0LTEwLTA3IGF0IDExOjMxICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gSXQgaXMgaW1wb3NzaWJsZSB0byBhZGQgZWFj
aCBhbmQgZXZlcnkgcG9zc2libGUgRERQIHBhdGggY29tYmluYXRpb24NCj4gZm9yIGVhY2ggYW5k
IGV2ZXJ5IHBvc3NpYmxlIGNvbWJpbmF0aW9uIG9mIFNvQyBhbmQgYm9hcmQ6IHJpZ2h0IG5vdywN
Cj4gdGhpcyBkcml2ZXIgaGFyZGNvZGVzIGNvbmZpZ3VyYXRpb24gZm9yIDEwIFNvQ3MgYW5kIHRo
aXMgaXMgZ29pbmcgdG8NCj4gZ3JvdyBsYXJnZXIgYW5kIGxhcmdlciwgYW5kIHdpdGggbmV3IGhh
Y2tzIGxpa2UgdGhlIGludHJvZHVjdGlvbiBvZg0KPiBtdGtfZHJtX3JvdXRlIHdoaWNoIGlzIGFu
eXdheSBub3QgZW5vdWdoIGZvciBhbGwgZmluYWwgcm91dGVzIGFzIHRoZQ0KPiBEU0kgY2Fubm90
IGJlIGNvbm5lY3RlZCB0byBNRVJHRSBpZiBpdCdzIG5vdCBhIGR1YWwtRFNJLCBvciBlbmFibGlu
Zw0KPiBEU0MgcHJldmVudGl2ZWx5IGRvZXNuJ3Qgd29yayBpZiB0aGUgZGlzcGxheSBkb2Vzbid0
IHN1cHBvcnQgaXQsIG9yDQo+IG90aGVycy4NCj4gDQo+IFNpbmNlIHByYWN0aWNhbGx5IGFsbCBk
aXNwbGF5IElQcyBpbiBNZWRpYVRlayBTb0NzIHN1cHBvcnQgYmVpbmcNCj4gaW50ZXJjb25uZWN0
ZWQgd2l0aCBkaWZmZXJlbnQgaW5zdGFuY2VzIG9mIG90aGVyLCBvciB0aGUgc2FtZSwgSVBzDQo+
IG9yIHdpdGggZGlmZmVyZW50IElQcyBhbmQgaW4gZGlmZmVyZW50IGNvbWJpbmF0aW9ucywgdGhl
IGZpbmFsIEREUA0KPiBwaXBlbGluZSBpcyBlZmZlY3RpdmVseSBhIGJvYXJkIHNwZWNpZmljIGNv
bmZpZ3VyYXRpb24uDQo+IA0KPiBJbXBsZW1lbnQgT0YgZ3JhcGhzIHN1cHBvcnQgdG8gdGhlIG1l
ZGlhdGVrLWRybSBkcml2ZXJzLCBhbGxvd2luZyB0bw0KPiBzdG9wIGhhcmRjb2RpbmcgdGhlIHBh
dGhzLCBhbmQgcHJldmVudGluZyB0aGlzIGRyaXZlciB0byBnZXQgYSBodWdlDQo+IGFtb3VudCBv
ZiBhcnJheXMgZm9yIGVhY2ggYm9hcmQgYW5kIFNvQyBjb21iaW5hdGlvbiwgYWxzbyBwYXZpbmcg
dGhlDQo+IHdheSB0byBzaGFyZSB0aGUgc2FtZSBtdGtfbW1zeXNfZHJpdmVyX2RhdGEgYmV0d2Vl
biBtdWx0aXBsZSBTb0NzLA0KPiBtYWtpbmcgaXQgbW9yZSBzdHJhaWdodGZvcndhcmQgdG8gYWRk
IHN1cHBvcnQgZm9yIG5ldyBjaGlwcy4NCj4gDQo+IFJldmlld2VkLWJ5OiBBbGV4YW5kcmUgTWVy
Z25hdCA8YW1lcmduYXRAYmF5bGlicmUuY29tPg0KPiBUZXN0ZWQtYnk6IEFsZXhhbmRyZSBNZXJn
bmF0IDxhbWVyZ25hdEBiYXlsaWJyZS5jb20+DQo+IEFja2VkLWJ5OiBTdWkgSmluZ2ZlbmcgPHN1
aS5qaW5nZmVuZ0BsaW51eC5kZXY+DQo+IFRlc3RlZC1ieTogTWljaGFlbCBXYWxsZSA8bXdhbGxl
QGtlcm5lbC5vcmc+ICMgb24ga29udHJvbi1zYmMtaTEyMDANCj4gU2lnbmVkLW9mZi1ieTogQW5n
ZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFi
b3JhLmNvbT4NCj4gLS0tDQoNCltzbmlwXQ0KDQo+ICsNCj4gK2Jvb2wgbXRrX292bF9hZGFwdG9y
X2lzX2NvbXBfcHJlc2VudChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUpDQo+ICt7DQo+ICsJZW51
bSBtdGtfb3ZsX2FkYXB0b3JfY29tcF90eXBlIHR5cGU7DQo+ICsJaW50IHJldDsNCj4gKw0KPiAr
CXJldCA9IG92bF9hZGFwdG9yX29mX2dldF9kZHBfY29tcF90eXBlKG5vZGUsICZ0eXBlKTsNCj4g
KwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gZmFsc2U7DQo+ICsNCj4gKwlpZiAodHlwZSA+PSBPVkxf
QURBUFRPUl9UWVBFX05VTSkNCj4gKwkJcmV0dXJuIGZhbHNlOw0KPiArDQo+ICsJLyoNCj4gKwkg
KiBJbiB0aGUgY29udGV4dCBvZiBtZWRpYXRlay1kcm0sIEVUSERSLCBNRFBfUkRNQSBhbmQgUGFk
ZGluZyBhcmUNCj4gKwkgKiB1c2VkIGV4Y2x1c2l2ZWx5IGJ5IE9WTCBBZGFwdG9yOiBpZiB0aGlz
IGNvbXBvbmVudCBpcyBub3Qgb25lIG9mDQo+ICsJICogdGhvc2UsIGl0J3MgbGlrZWx5IG5vdCBh
biBPVkwgQWRhcHRvciBwYXRoLg0KPiArCSAqLw0KPiArCXJldHVybiB0eXBlID09IE9WTF9BREFQ
VE9SX1RZUEVfRVRIRFIgfHwNCj4gKwkgICAgICAgdHlwZSA9PSBPVkxfQURBUFRPUl9UWVBFX01E
UF9SRE1BIHx8DQo+ICsJICAgICAgIHR5cGUgPT0gT1ZMX0FEQVBUT1JfVFlQRV9QQURESU5HOw0K
PiArfQ0KPiArDQoNCltzbmlwXQ0KDQo+ICsNCj4gK3N0YXRpYyBpbnQgbXRrX2RybV9vZl9nZXRf
ZGRwX2VwX2NpZChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUsDQo+ICsJCQkJICAgICBpbnQgb3V0
cHV0X3BvcnQsIGVudW0gbXRrX2NydGNfcGF0aCBjcnRjX3BhdGgsDQo+ICsJCQkJICAgICBzdHJ1
Y3QgZGV2aWNlX25vZGUgKipuZXh0LCB1bnNpZ25lZCBpbnQgKmNpZCkNCj4gK3sNCj4gKwlzdHJ1
Y3QgZGV2aWNlX25vZGUgKmVwX2Rldl9ub2RlLCAqZXBfb3V0Ow0KPiArCWVudW0gbXRrX2RkcF9j
b21wX3R5cGUgY29tcF90eXBlOw0KPiArCWludCByZXQ7DQo+ICsNCj4gKwllcF9vdXQgPSBvZl9n
cmFwaF9nZXRfZW5kcG9pbnRfYnlfcmVncyhub2RlLCBvdXRwdXRfcG9ydCwgY3J0Y19wYXRoKTsN
Cj4gKwlpZiAoIWVwX291dCkNCj4gKwkJcmV0dXJuIC1FTk9FTlQ7DQo+ICsNCj4gKwllcF9kZXZf
bm9kZSA9IG9mX2dyYXBoX2dldF9yZW1vdGVfcG9ydF9wYXJlbnQoZXBfb3V0KTsNCj4gKwlvZl9u
b2RlX3B1dChlcF9vdXQpOw0KPiArCWlmICghZXBfZGV2X25vZGUpDQo+ICsJCXJldHVybiAtRUlO
VkFMOw0KPiArDQo+ICsJLyoNCj4gKwkgKiBQYXNzIHRoZSBuZXh0IG5vZGUgcG9pbnRlciByZWdh
cmRsZXNzIG9mIGZhaWx1cmVzIGluIHRoZSBsYXRlciBjb2RlDQo+ICsJICogc28gdGhhdCBpZiB0
aGlzIGZ1bmN0aW9uIGlzIGNhbGxlZCBpbiBhIGxvb3AgaXQgd2lsbCB3YWxrIHRocm91Z2ggYWxs
DQo+ICsJICogb2YgdGhlIHN1YnNlcXVlbnQgZW5kcG9pbnRzIGFueXdheS4NCj4gKwkgKi8NCj4g
KwkqbmV4dCA9IGVwX2Rldl9ub2RlOw0KPiArDQo+ICsJaWYgKCFvZl9kZXZpY2VfaXNfYXZhaWxh
YmxlKGVwX2Rldl9ub2RlKSkNCj4gKwkJcmV0dXJuIC1FTk9ERVY7DQo+ICsNCj4gKwlyZXQgPSBt
dGtfZHJtX29mX2dldF9kZHBfY29tcF90eXBlKGVwX2Rldl9ub2RlLCAmY29tcF90eXBlKTsNCj4g
KwlpZiAocmV0KSB7DQo+ICsJCWlmIChtdGtfb3ZsX2FkYXB0b3JfaXNfY29tcF9wcmVzZW50KGVw
X2Rldl9ub2RlKSkgew0KPiArCQkJKmNpZCA9ICh1bnNpZ25lZCBpbnQpRERQX0NPTVBPTkVOVF9E
Uk1fT1ZMX0FEQVBUT1I7DQo+ICsJCQlyZXR1cm4gMDsNCj4gKwkJfQ0KPiArCQlyZXR1cm4gcmV0
Ow0KPiArCX0NCj4gKw0KPiArCXJldCA9IG10a19kZHBfY29tcF9nZXRfaWQoZXBfZGV2X25vZGUs
IGNvbXBfdHlwZSk7DQo+ICsJaWYgKHJldCA8IDApDQo+ICsJCXJldHVybiByZXQ7DQo+ICsNCj4g
KwkvKiBBbGwgb2shIFBhc3MgdGhlIENvbXBvbmVudCBJRCB0byB0aGUgY2FsbGVyLiAqLw0KPiAr
CSpjaWQgPSAodW5zaWduZWQgaW50KXJldDsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiAr
DQo+ICsvKioNCj4gKyAqIG10a19kcm1fb2ZfZGRwX3BhdGhfYnVpbGRfb25lIC0gQnVpbGQgYSBE
aXNwbGF5IEhXIFBpcGVsaW5lIGZvciBhIENSVEMgUGF0aA0KPiArICogQGRldjogICAgICAgICAg
VGhlIG1lZGlhdGVrLWRybSBkZXZpY2UNCj4gKyAqIEBjcGF0aDogICAgICAgIENSVEMgUGF0aCBy
ZWxhdGl2ZSB0byBhIFZETyBvciBNTVNZUw0KPiArICogQG91dF9wYXRoOiAgICAgUG9pbnRlciB0
byBhbiBhcnJheSB0aGF0IHdpbGwgY29udGFpbiB0aGUgbmV3IHBpcGVsaW5lDQo+ICsgKiBAb3V0
X3BhdGhfbGVuOiBOdW1iZXIgb2YgZW50cmllcyBpbiB0aGUgcGlwZWxpbmUgYXJyYXkNCj4gKyAq
DQo+ICsgKiBNZWRpYVRlayBTb0NzIGNhbiB1c2UgZGlmZmVyZW50IEREUCBoYXJkd2FyZSBwaXBl
bGluZXMgKG9yIHBhdGhzKSBkZXBlbmRpbmcNCj4gKyAqIG9uIHRoZSBib2FyZC1zcGVjaWZpYyBk
ZXNpcmVkIGRpc3BsYXkgY29uZmlndXJhdGlvbjsgdGhpcyBmdW5jdGlvbiB3YWxrcw0KPiArICog
dGhyb3VnaCBhbGwgb2YgdGhlIG91dHB1dCBlbmRwb2ludHMgc3RhcnRpbmcgZnJvbSBhIFZETyBv
ciBNTVNZUyBoYXJkd2FyZQ0KPiArICogaW5zdGFuY2UgYW5kIGJ1aWxkcyB0aGUgcmlnaHQgcGlw
ZWxpbmUgYXMgc3BlY2lmaWVkIGluIGRldmljZSB0cmVlcy4NCj4gKyAqDQo+ICsgKiBSZXR1cm46
DQo+ICsgKiAqICUwICAgICAgIC0gRGlzcGxheSBIVyBQaXBlbGluZSBzdWNjZXNzZnVsbHkgYnVp
bHQgYW5kIHZhbGlkYXRlZA0KPiArICogKiAlLUVOT0VOVCAtIERpc3BsYXkgcGlwZWxpbmUgd2Fz
IG5vdCBzcGVjaWZpZWQgaW4gZGV2aWNlIHRyZWUNCj4gKyAqICogJS1FSU5WQUwgLSBEaXNwbGF5
IHBpcGVsaW5lIGJ1aWx0IGJ1dCB2YWxpZGF0aW9uIGZhaWxlZA0KPiArICogKiAlLUVOT01FTSAt
IEZhaWx1cmUgdG8gYWxsb2NhdGUgcGlwZWxpbmUgYXJyYXkgdG8gcGFzcyB0byB0aGUgY2FsbGVy
DQo+ICsgKi8NCj4gK3N0YXRpYyBpbnQgbXRrX2RybV9vZl9kZHBfcGF0aF9idWlsZF9vbmUoc3Ry
dWN0IGRldmljZSAqZGV2LCBlbnVtIG10a19jcnRjX3BhdGggY3BhdGgsDQo+ICsJCQkJCSBjb25z
dCB1bnNpZ25lZCBpbnQgKipvdXRfcGF0aCwNCj4gKwkJCQkJIHVuc2lnbmVkIGludCAqb3V0X3Bh
dGhfbGVuKQ0KPiArew0KPiArCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbmV4dCwgKnByZXYsICp2ZG8g
PSBkZXYtPnBhcmVudC0+b2Zfbm9kZTsNCj4gKwl1bnNpZ25lZCBpbnQgdGVtcF9wYXRoW0REUF9D
T01QT05FTlRfRFJNX0lEX01BWF0gPSB7IDAgfTsNCj4gKwl1bnNpZ25lZCBpbnQgKmZpbmFsX2Rk
cF9wYXRoOw0KPiArCXVuc2lnbmVkIHNob3J0IGludCBpZHggPSAwOw0KPiArCWJvb2wgb3ZsX2Fk
YXB0b3JfY29tcF9hZGRlZCA9IGZhbHNlOw0KPiArCWludCByZXQ7DQo+ICsNCj4gKwkvKiBHZXQg
dGhlIGZpcnN0IGVudHJ5IGZvciB0aGUgdGVtcF9wYXRoIGFycmF5ICovDQo+ICsJcmV0ID0gbXRr
X2RybV9vZl9nZXRfZGRwX2VwX2NpZCh2ZG8sIDAsIGNwYXRoLCAmbmV4dCwgJnRlbXBfcGF0aFtp
ZHhdKTsNCj4gKwlpZiAocmV0KSB7DQo+ICsJCWlmIChuZXh0ICYmIHRlbXBfcGF0aFtpZHhdID09
IEREUF9DT01QT05FTlRfRFJNX09WTF9BREFQVE9SKSB7DQo+ICsJCQlkZXZfZGJnKGRldiwgIkFk
ZGluZyBPVkwgQWRhcHRvciBmb3IgJXBPRlxuIiwgbmV4dCk7DQo+ICsJCQlvdmxfYWRhcHRvcl9j
b21wX2FkZGVkID0gdHJ1ZTsNCj4gKwkJfSBlbHNlIHsNCj4gKwkJCWlmIChuZXh0KQ0KPiArCQkJ
CWRldl9lcnIoZGV2LCAiSW52YWxpZCBjb21wb25lbnQgJXBPRlxuIiwgbmV4dCk7DQo+ICsJCQll
bHNlDQo+ICsJCQkJZGV2X2VycihkZXYsICJDYW5ub3QgZmluZCBmaXJzdCBlbmRwb2ludCBmb3Ig
cGF0aCAlZFxuIiwgY3BhdGgpOw0KPiArDQo+ICsJCQlyZXR1cm4gcmV0Ow0KPiArCQl9DQo+ICsJ
fQ0KPiArCWlkeCsrOw0KPiArDQo+ICsJLyoNCj4gKwkgKiBXYWxrIHRocm91Z2ggcG9ydCBvdXRw
dXRzIHVudGlsIHdlIHJlYWNoIHRoZSBsYXN0IHZhbGlkIG1lZGlhdGVrLWRybSBjb21wb25lbnQu
DQo+ICsJICogVG8gYmUgdmFsaWQsIHRoaXMgbXVzdCBlbmQgd2l0aCBhbiAiaW52YWxpZCIgY29t
cG9uZW50IHRoYXQgaXMgYSBkaXNwbGF5IG5vZGUuDQo+ICsJICovDQo+ICsJZG8gew0KPiArCQlw
cmV2ID0gbmV4dDsNCj4gKwkJcmV0ID0gbXRrX2RybV9vZl9nZXRfZGRwX2VwX2NpZChuZXh0LCAx
LCBjcGF0aCwgJm5leHQsICZ0ZW1wX3BhdGhbaWR4XSk7DQo+ICsJCW9mX25vZGVfcHV0KHByZXYp
Ow0KPiArCQlpZiAocmV0KSB7DQo+ICsJCQlvZl9ub2RlX3B1dChuZXh0KTsNCj4gKwkJCWJyZWFr
Ow0KPiArCQl9DQo+ICsNCj4gKwkJLyoNCj4gKwkJICogSWYgdGhpcyBpcyBhbiBPVkwgYWRhcHRv
ciBleGNsdXNpdmUgY29tcG9uZW50IGFuZCBvbmUgb2YgdGhvc2UNCj4gKwkJICogd2FzIGFscmVh
ZHkgYWRkZWQsIGRvbid0IGFkZCBhbm90aGVyIGluc3RhbmNlIG9mIHRoZSBnZW5lcmljDQo+ICsJ
CSAqIEREUF9DT01QT05FTlRfT1ZMX0FEQVBUT1IsIGFzIHRoaXMgaXMgdXNlZCBvbmx5IHRvIGRl
Y2lkZSB3aGV0aGVyDQo+ICsJCSAqIHRvIHByb2JlIHRoYXQgY29tcG9uZW50IG1hc3RlciBkcml2
ZXIgb2Ygd2hpY2ggb25seSBvbmUgaW5zdGFuY2UNCj4gKwkJICogaXMgbmVlZGVkIGFuZCBwb3Nz
aWJsZS4NCj4gKwkJICovDQo+ICsJCWlmICh0ZW1wX3BhdGhbaWR4XSA9PSBERFBfQ09NUE9ORU5U
X0RSTV9PVkxfQURBUFRPUikgew0KPiArCQkJaWYgKCFvdmxfYWRhcHRvcl9jb21wX2FkZGVkKQ0K
PiArCQkJCW92bF9hZGFwdG9yX2NvbXBfYWRkZWQgPSB0cnVlOw0KPiArCQkJZWxzZQ0KPiArCQkJ
CWlkeC0tOw0KPiArCQl9DQo+ICsJfSB3aGlsZSAoKytpZHggPCBERFBfQ09NUE9ORU5UX0RSTV9J
RF9NQVgpOw0KDQpGb3IgdGhlIG10ODE5NSBleHRlcm5hbCBkaXNwbGF5IHBhdGgsIHRoZSBPRiBn
cmFwaCBpcw0KDQptZHBfcmRtYSAoMCB+IDcpIC0+IHBhZGRpbmcgKDAgfiA3KSAtPiBtZXJnZSAo
MSB+IDQpIC0+IGV0aGRyIC0+IG1lcmdlNQ0KDQphbmQgdGhpcyBmdW5jdGlvbiB3b3VsZCBnZW5l
cmF0ZSB0aGUgcGF0aCBhcw0KDQpvdmxfYWRhcHRvciAtPiBtZXJnZSAoMSB+IDQpIC0+IG1lcmdl
IDUNCg0KVGhpcyBpcyBub3Qgd2hhdCBJIGV4cGVjdC4NCklzIGFueSB0aGluZyB3cm9uZyB3aXRo
IG1lPw0KDQpSZWdhcmRzLA0KQ0sNCg0KDQo+ICsNCj4gKwkvKg0KPiArCSAqIFRoZSBkZXZpY2Ug
Y29tcG9uZW50IG1pZ2h0IG5vdCBiZSBlbmFibGVkOiBpbiB0aGF0IGNhc2UsIGRvbid0DQo+ICsJ
ICogY2hlY2sgdGhlIGxhc3QgZW50cnkgYW5kIGp1c3QgcmVwb3J0IHRoYXQgdGhlIGRldmljZSBp
cyBtaXNzaW5nLg0KPiArCSAqLw0KPiArCWlmIChyZXQgPT0gLUVOT0RFVikNCj4gKwkJcmV0dXJu
IHJldDsNCj4gKw0KPiArCS8qIElmIHRoZSBsYXN0IGVudHJ5IGlzIG5vdCBhIGZpbmFsIGRpc3Bs
YXkgb3V0cHV0LCB0aGUgY29uZmlndXJhdGlvbiBpcyB3cm9uZyAqLw0KPiArCXN3aXRjaCAodGVt
cF9wYXRoW2lkeCAtIDFdKSB7DQo+ICsJY2FzZSBERFBfQ09NUE9ORU5UX0RQX0lOVEYwOg0KPiAr
CWNhc2UgRERQX0NPTVBPTkVOVF9EUF9JTlRGMToNCj4gKwljYXNlIEREUF9DT01QT05FTlRfRFBJ
MDoNCj4gKwljYXNlIEREUF9DT01QT05FTlRfRFBJMToNCj4gKwljYXNlIEREUF9DT01QT05FTlRf
RFNJMDoNCj4gKwljYXNlIEREUF9DT01QT05FTlRfRFNJMToNCj4gKwljYXNlIEREUF9DT01QT05F
TlRfRFNJMjoNCj4gKwljYXNlIEREUF9DT01QT05FTlRfRFNJMzoNCj4gKwkJYnJlYWs7DQo+ICsJ
ZGVmYXVsdDoNCj4gKwkJZGV2X2VycihkZXYsICJJbnZhbGlkIGRpc3BsYXkgaHcgcGlwZWxpbmUu
IExhc3QgY29tcG9uZW50OiAlZCAocmV0PSVkKVxuIiwNCj4gKwkJCXRlbXBfcGF0aFtpZHggLSAx
XSwgcmV0KTsNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJfQ0KPiArDQo+ICsJZmluYWxfZGRw
X3BhdGggPSBkZXZtX2ttZW1kdXAoZGV2LCB0ZW1wX3BhdGgsIGlkeCAqIHNpemVvZih0ZW1wX3Bh
dGhbMF0pLCBHRlBfS0VSTkVMKTsNCj4gKwlpZiAoIWZpbmFsX2RkcF9wYXRoKQ0KPiArCQlyZXR1
cm4gLUVOT01FTTsNCj4gKw0KPiArCWRldl9kYmcoZGV2LCAiRGlzcGxheSBIVyBQaXBlbGluZSBi
dWlsdCB3aXRoICVkIGNvbXBvbmVudHMuXG4iLCBpZHgpOw0KPiArDQo+ICsJLyogUGlwZWxpbmUg
YnVpbHQhICovDQo+ICsJKm91dF9wYXRoID0gZmluYWxfZGRwX3BhdGg7DQo+ICsJKm91dF9wYXRo
X2xlbiA9IGlkeDsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo=

