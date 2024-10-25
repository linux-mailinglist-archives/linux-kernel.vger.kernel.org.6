Return-Path: <linux-kernel+bounces-382379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A079B0D02
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652F61F24F99
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6F920BB30;
	Fri, 25 Oct 2024 18:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="NWPkVb5l"
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D40D2064E6;
	Fri, 25 Oct 2024 18:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880263; cv=fail; b=vAWICyFCQxGObL3Vkiw6lG7jeFj4LgP3NQqsTXCubXpOFLqCB3z7jksilFdUDwGIrZsLkwSMhW6TVkklyihTh3YTQLtG8jDThMtG9xlFEecv0NZQpUc6ouHQG5RGhRLgo0WClrZwl+luRZEnqb/MqS3AcozEwOfec6VpJXN/HmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880263; c=relaxed/simple;
	bh=rm4E8TXYMrT/y/GbMAp4yez6A6PKXzBhaJEMtwI+wds=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tZkFNQJsviDGawZNPj44OGLHGBuNN+a4ye8gvpA4bTxuSKj7/gutN30BUToZO/uFATn493KKaHq714pQbqnvhtdaugdRJ8tAhHc4sc+5dXhbzSt3GB1FhKfxVZXloOPuZzHWvH29m0mhT3RHtl5KVtw8a8yPkv8S5XUX3fH6odY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=NWPkVb5l; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PGF6EA026474;
	Fri, 25 Oct 2024 18:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=/8rYn/xzsgJ3bHN19vnpsZH8AQCgB
	DJtVxVpS9abjdg=; b=NWPkVb5lfYUHI4R3HMXTZrQrfc8uL8lIsC7Shduo7xCOR
	0Lc/LBkQZ52BgyeVbQn6x4MxWKbqu589B0i/iNmpxzEYWnhL7fCvYaT3xSaW/ejQ
	nceyhwzxI1A1q1/HxgUM4ixc+7mspnG0R+qBbsGdqYFLZaZ4Eeo55OKpU6CR6swz
	V0I02Dz5MqDNDM7Bdl9WPy5nIXVTT8ppQ0eDlWrmwXJII3rq/pt0urCnvsjCKKYc
	rPeVBoLCSR0SwXDfariGQ6DovbPnC1vo8ETqIioSJqQdcOvY4v1iyQFAGLycoC+b
	XUOjTmRcsBtWeXJQADaZzMEsl8V28Pc385/3frJ5A==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 42c2yeed8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 18:17:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bo35I1uGOz5+XJdOXR6yTvOAoVw1Jj0GIIvi9A0gUF2hXn4QwPHmHMbd6n29ewbhHdBDY8Ldx69EhLQG1JMM6CgZWlIAE1KGCADb1GEcHrS/wEyX/5TjazCQ+G0/8G6143ubLl8WU8uHQqzr8N0t/5cBmSbDELtm9HaZkKbt1QEc84wPM4Vj3CyFWHs8F7K5tuRFRqRLeqqwOxALMOrawmX5IXvlNklqIntJdp44b/WWJZMJPhcsmeUghEIW+sYh3FOhObMMU7XuzCE6xuVaApLdDv8TQZVCRGvf8vExv3A5b/c2sHLFcaZQSkYPPm3VunxsnhCbGzAKpjkXYbEGTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8rYn/xzsgJ3bHN19vnpsZH8AQCgBDJtVxVpS9abjdg=;
 b=QF14rJfI95c4695bkaBFYpUXiyyEBL6RIbrd47eDAobZL4MRnzswhs2fuKx3QCkCSoaHJyfynkuHl5R/SQ4rDDgOkjA4XauEy2dO1W7MjBUYUOnFUu52bQRlTJhMLlVOCB+vKnKNv+ET9wyl2RtJvTvFq+vS6wTNKhOyxTMP2RsiP3utEkbhl6SBthjhCOCJYHfKQZxtmUsp4g7NOsR1/VovagbYdyRtEPR6dYcm/S2IVl5YZad4I2VIzLlb6DXQGmi3UtUw6NtFekSeC/Kq+nVKQzznFfweeyVY5I27OC9jlAwMkgGmzUjzaBx0AVEggWX9PPEpOPmUAdhdPjHKdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from MW5PR13MB5632.namprd13.prod.outlook.com (2603:10b6:303:197::16)
 by BN0PR13MB4616.namprd13.prod.outlook.com (2603:10b6:408:124::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.22; Fri, 25 Oct
 2024 18:17:20 +0000
Received: from MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197]) by MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 18:17:20 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: "linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Boot-time initiative (SIG) thoughts and next steps
Thread-Topic: Boot-time initiative (SIG) thoughts and next steps
Thread-Index: AdsnCeBneydgAwbrQsOuFQyqBOu5BA==
Date: Fri, 25 Oct 2024 18:17:20 +0000
Message-ID:
 <MW5PR13MB5632321E93B031C0E107DB38FD4F2@MW5PR13MB5632.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR13MB5632:EE_|BN0PR13MB4616:EE_
x-ms-office365-filtering-correlation-id: 8116ea5c-fe57-4428-5336-08dcf52143fa
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YSSbQ2z5WoVAxPGI+unV9mluKRROOaxf98awA9viPuLcyo7HfEfsquoW3kYE?=
 =?us-ascii?Q?Sx/r56hoM4sFiTPU2WHgbRHHG7DNiy5N1IaKH5eWhNecoTv61W5M8xCX8Yly?=
 =?us-ascii?Q?G80TcRCBmERv2oICo0IMTJfpY9X0awBr1pjyKlZQJ9OJQcpqps2EwEJYvopO?=
 =?us-ascii?Q?KPs8SX2XwG2dyfoX7iuIpeCUJZ71bOzPfwDO0vXAlEuI8XIeIMI/VWYaRa6c?=
 =?us-ascii?Q?1OCilO2TceF9rcPw0898I/6D+9C+Cw5ti2H+6j2RnGaEsOZwUODGzd8SouPy?=
 =?us-ascii?Q?b7IH5OSaCgyjw5lGvdg+BVzALdSqA1uQN6ZU4LpZbEI3ZG4k5jM32ZvkmD1c?=
 =?us-ascii?Q?OT/c2KpxUJf+0VJdGn3BaiM7XbqxQaNQ4weg9g0oDWjGnryvsqUzU5+9Opq6?=
 =?us-ascii?Q?4wB+TjyD4D+8P/dj+4K/13QfWxvzJLtmvI1U5YA2sn6QVnR3BvWILbrzZl7D?=
 =?us-ascii?Q?ecSazr7XgsKizVr6OAgUeyk4ao0Rhf5/2gpsfnNy33YFszHvC1gK7x3TSJM1?=
 =?us-ascii?Q?WZKoNnG2DmrrvajJ2J6qIseuGtlFeLgG+bzBhNM3GZBMuJSb7AF4O87yH9iC?=
 =?us-ascii?Q?3qM7jcuVRhYXi5SB3l8gzkUmEGxD1dvg+kLdqvPjvnpF4fn9hkA1+Ykr/Vby?=
 =?us-ascii?Q?yXz1fzHC8vo0/oFWdKHuvsSD2FTOGyVUStho0BYWicaQQpa0g1h0Zg3LCfwC?=
 =?us-ascii?Q?dVEXdG0B1jpHznuzFo7F545G1N2Zrmyy6wIAuIAVruKxghreuuGTR/btlyvS?=
 =?us-ascii?Q?9QuDOr0lyI3HkiVUWDoF6Pc+wo2Vju7/mJWO0pXfWV8LZaoCWU2WaKf5MnNH?=
 =?us-ascii?Q?S8ayjJrDx0YijUZ3rpj/RLLx4gun77zecqoW0JJe0qfXVf9VFt52Cv+ENNqG?=
 =?us-ascii?Q?i0hxiQNfZd3O474+HveCiwWYOWKer2KSnvBbHG6ceFxAAkk0ntC0x0EyzovR?=
 =?us-ascii?Q?YW6WP5KOqRmJ+LCrgZ6wXsriHjdy6b67KP1RE75oOBl+KMcQNn0cOF+iYEpY?=
 =?us-ascii?Q?aQtPb3sYAdEHMBeSQJ6ibGH7W127Irj/a2CRSetHKtHHDXckLG6EG6P5RSuY?=
 =?us-ascii?Q?hTpqOSjWhsfe9IbwqtE53R7SX399cOFhBika1ONMw/R6YvP6wlbrU9+dWnno?=
 =?us-ascii?Q?hjtcyYcMGgiMzKVGNSnWDQ1jVhFMsk8oT2sfonYm48p3Y4yN/ITnewYWtlRh?=
 =?us-ascii?Q?XN4p0T6RGunNw/W2dMTYlx4JpA2r6wtOTuufaMybSv7jKDHD2rzmKrb5uWNU?=
 =?us-ascii?Q?CPFrbHCS6gLSJR5Got8DKFFcV4TjiFhrg5OYa5QIniiuchFjUkBsJOI1F1m3?=
 =?us-ascii?Q?WZfz9Ts8cktPlGU8yI3L3aCr9YsS3rLjNLPN+Mh0/1/9sa0jt0CFhV9OGTjl?=
 =?us-ascii?Q?g/YEjll5kYhPJeTzfUdiVe3nOnov?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR13MB5632.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8il/3gCHuGMRhMQPqsRPwoYxcTKNwzjl5XI+BKPo5GGDdLEAleYi7unoMWb8?=
 =?us-ascii?Q?60tFQsf4sYLSs0ZPcc0hIaM9OmvT20/Mgx77ioxDlvvrrw5z5osLHq5lEypE?=
 =?us-ascii?Q?rqlN2PJQPGjFp8u5LojaCtvVChqGPOrsGDT8XGtGqtPjcp5tp2/oZmACiTWP?=
 =?us-ascii?Q?1UL+FmgYHjaZL6GzdaGKEBQBuK4Z4JPImD1yKw5QfckjT4BADYmSZq4bQOCL?=
 =?us-ascii?Q?H6HkM5L5qwWgZmiuSAf9WoIWKnOAnqYoAmcWKlo3MtYamsVkFVAmM5qe2t86?=
 =?us-ascii?Q?IwwdllLYrJ3jhpDtzyZkmeawnJSpeChzPbpEsgyjR0mNRotFw+dB1rprKK6H?=
 =?us-ascii?Q?hCkwcM5Ydw6RhZJ86tGr5N/MlR50D7uGL0gPwtB8LfPfXLpNVHMgWULQkhiL?=
 =?us-ascii?Q?uYPHoEqnwRTcg1AGcwMRmnIzJbzmj2hFiOgihTTXmAJbR8WIQL3pfPzU+uiB?=
 =?us-ascii?Q?hxM1BpGatfCKCxHD59QUiWxfjoX4Ioda3AoPJzQ3R5PQWeSQycLQsB/7KEXJ?=
 =?us-ascii?Q?2tu9Nv8tEhc+be2Y3jA7yt6Jepajw1G4MjAgew70uBJsvDQf3rv26EBuz5et?=
 =?us-ascii?Q?eZqRHg1sYVRFHoNwh4E//76O/oLJyhy7mPNcqg/a3pLgxMejwFallr8u3Zj/?=
 =?us-ascii?Q?nCTIX+TZlQACChXSsm5oUvyzMB4Q9HuMZOelJdGPLcF6BtYqcwDLWeBwiMi6?=
 =?us-ascii?Q?QLbVxrKLrwfbSI2bOHBKCZudsvoW8UK74mU1vD7vRUv5hWfzOHBCRlg4Ay9m?=
 =?us-ascii?Q?K8vo6Y09vkVRgp6a4OlbKYAV6oAehp+e2emJfswshuCBaV9xY4oO7r1LC8G7?=
 =?us-ascii?Q?xRjLVBnR8Ui0zn1K+TD3oAcgF8G43UVoMLQG//piw58LdXlJsmUzmf2PD+9/?=
 =?us-ascii?Q?AMVT7i3mUDnvNAIlMNKfOYBG1m7XHW3Quu+4kRT+vvEkziWeICC7WPUQ3abg?=
 =?us-ascii?Q?Nl4NiuvoPcLTIERXWai37wAQVxcLyfJTkyC1V/Zr2F1aUEY6jkXgBCQFwHEa?=
 =?us-ascii?Q?gCMfM3DuQ+hxeZELkuJfZapXM5KZyzLx7/5dB3W6BzaTcqBT2sWu+BZBK90p?=
 =?us-ascii?Q?tyrBAAuw5RT/dJ9LhomkFt3tDx7gvDKo8PzUXKfiEYbRIDyQTrBEnUpb/fSm?=
 =?us-ascii?Q?ZJqn7OTq0ADytUB8nxQIoOdSRZn/d3pps7KwGdVS65uGSlj181qjuCkovEgr?=
 =?us-ascii?Q?ZJlAhr6J0pgCOpkZU7XxdNa+3XK0BlKE8iPtWr1IQgXmVoti5ucQOYpf1phU?=
 =?us-ascii?Q?QVRHnSkOvh4JkNBS+iNLvi5JpdtDqBUEko8VE+ebVS6sKXUt35tR/cVGNN4f?=
 =?us-ascii?Q?YC3zWXBWHAw/IOzmnq1CH7ogpDRFiyybZMcTyJ98WtqNbgL2by8OURVb2C+i?=
 =?us-ascii?Q?FYwyKVaTmXIs6JyiJPStzG0BMG6DGETFvXwXyUTS0ilNPxP3l6+/vfer6GNA?=
 =?us-ascii?Q?IoiaNVRPgKDjnwh4ESbB8DYU5Ts0aAG4Jr1Ihq+ZDLFChlUtNLljZx17dYB+?=
 =?us-ascii?Q?qWAUhijUySpI+AfkB7O8smB+6SsNeOtwbYraBvJeykkM1NdETLoKoo1gmaxB?=
 =?us-ascii?Q?lIwweTZ2ZNLLSRZnMgI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+nmbMo6IlPJh6E48/P3tIFZdQ6XK4qQr9LG3BU4kioT8qOoFOolSmc8iwyofDiyNIiMDiarFZZ6131YSLBXADLmtc7f5N3A+aepTR+A35kZDrrv/HdXcYJbqUUkfGc1gCY3AyEoX9oqx5QxmIp4scCHZnaxWoF5+63J62m4rHCxSVGmPGzArSKLChIAzAnOYvdn8hn5Hm9bBvakRCDE6qybstviT6kq34Di5c7ITNRnp/7RvBEupAxcsQENQRzPWE3oY0V1dknjKwLSbjcGNov21yivpjdR2XiIOu8wuUxU09W99PlBBjeRSuShW2d9mr30/l/uRSLDNNzj9h2O0/EzvS31iUabahFX2I0uuQnyU8odiQH0TfsyPSdcvCxI087pGCC5pcLrIc24GMJLtv26zPHToZFih/vF5sVuDLd7npNGMwXiiqyw2EfhT5m2hhD2vEn27xDEUpCTVkkS2lDgAkfAhaU7gv9u4rxV9uQSAF5qAZZYXMW8bIGrsFtWzt/aaSj5sUei6KSJzeaovgbIDaHrx1aOhj03kkCseurY6fCEzWjpl5PAvPgDXex3EpkBonlDw6GAuOQUZMrljhsJCEnzT6ouww6IvRY3G7pdvLfVIUfEIXf9GdIOCBLQe
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR13MB5632.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8116ea5c-fe57-4428-5336-08dcf52143fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 18:17:20.2449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ESqJsUQGtHBlXKCbgprPjkl5Zz0dcH1dx43k7w2awaFw1faNPkX7w57HCjZ4x/XSBiggI9b/F1JnGICvHnhnYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB4616
X-Proofpoint-ORIG-GUID: nxTFMMfQDcxLue2yweavN3VrGU6OXAEO
X-Proofpoint-GUID: nxTFMMfQDcxLue2yweavN3VrGU6OXAEO
X-Sony-Outbound-GUID: nxTFMMfQDcxLue2yweavN3VrGU6OXAEO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01

Hey Linux developers,

The response to my request to form a Special Interest Group for boot-time r=
eduction
for Linux has been really great.  Many people contacted me by e-mail and on=
 LinkedIn.

I had hoped to push out a script today to start to gather data on boot-time=
 on different
platforms, for people to run who had expressed interest in helping with thi=
s effort. But
I got overwhelmed with other tasks, and I may not get it done today.  I'll =
be in Tokyo next
week for Open Source Summit Japan.  If you are there, please try to catch m=
e and say hi.
Given that, I'll see how soon I can provide the script I'm talking about, a=
nd we can
discuss the goals and design of the script.

A couple of quick things:
There are lots of things to discuss, but here are a few things to get start=
ed with...

=3D wiki account =3D
The wiki where we'll be maintaining information about=20
boot time, and about activities of the boot time SIG, is the elinux wiki.
The page we'll be focusing on is: https://elinux.org/Boot_Time.
If you are interested in helping update and maintain the information there
(which I hope almost everyone is), then please make sure you have a user
account on the wiki.
If you don't have one, please go here:
https://elinux.org/Special:RequestAccount
I have to manually approve accounts in order to fight spambots.  It might
take a few days for me to get to your request.  It's very helpful if you
put a comment in one of the request fields about this being related to
the boot-time initiative or SIG, so I can distinguish your request from
spam requests.

=3D support for new developers =3D
A number of developers have asked me if they can participate and contribute=
,
even if they are not seasoned Linux kernel developers.  The answer is "Yes"=
!
I hope to provide a range of activities for people to provide data, help up=
date
the wiki, implement and run tests and perform research - even if they don't=
 have
any previous Linux development experience.  I hope it will be fun to partic=
ipate,
and very educational.

If you are new to Linux and have just joined this group, please review some
of the material on the Boot_Time page mentioned above.  We will be covering
more than just the kernel in the project, but one place to get started will=
 be
to look at the kernel source file init/main.c, particularly the function st=
art_kernel()
(which is where a lot of the "magic" happens at kernel startup time.)
Don't be afraid to ask questions.  Please ask them on this list so that oth=
ers benefit
from any answers provided.

=3D short-term plans =3D
I am building out the "membership" of the SIG over the very short term.  I =
have
some more individuals and companies to contact to see who wants to be invol=
ved.

Other things I'd like to do are:
 * start gathering boot timing data for different systems (using the script=
 I described above)
 * start pruning obsolete information and refactoring the boot-time materia=
l on the elinux wiki
    * (Yes - some of the material there is quite dated, so be sure to check=
 it out before you try to
       use some tool or technique - if something doesn't work, please send =
an e-mail or mark it in the wiki)
 * discuss planning for SIG video conference calls and meetings
     * I know I'm interested in having a boot-time micro-conference at Embe=
dded Linux
     Conference next year - but we need to discuss if we want regular calls=
 or other face-to-face
      meetings
 * perform a survey of existing boot-time reduction techniques, and see whe=
re they are
    in the pipeline of upstreaming or deployment in actual products
 * finally (for this list), brainstorm what activities the SIG should do, a=
nd how we can
    collaborate on those.  I've started a list at: https://elinux.org/Boot_=
Time_Project_Ideas
    that you can look at and comment on (either on this list, or on the wik=
i).

I'll be busy with business travel and Sony work next week, but I hope I sti=
ll
find some time to follow up on this .  I look forward to working with many =
of you
reading this, on improving this area of Linux.
 -- Tim


