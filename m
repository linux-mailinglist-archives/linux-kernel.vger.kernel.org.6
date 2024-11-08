Return-Path: <linux-kernel+bounces-402501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D01C29C286B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 303D3B23323
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A07E20DD78;
	Fri,  8 Nov 2024 23:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="UURd6zxz"
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCAF2010E1;
	Fri,  8 Nov 2024 23:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109685; cv=fail; b=SNitO2TN8JkywKDniPN3cotUef2+iN7RXc7dw0plAWbfOsv0NRgCqD3UnZ41UNQkFXsBAOUO6m6CCAvW9lq9ysQa7MJjEUaCscVSiD/lQTaJrjAz5Yt+Nsu0gAWnuWOJF472Nu1f2BzkbCmQ/NrzPhTtgEbj2L8vGYs3FAdlYPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109685; c=relaxed/simple;
	bh=xhjnLaqa9pOYZJRMbj1ObRNXthnEIa0iYtOPMaeCaLo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tL31RhmqIhXLf6xSNCB8nrxfMbRRf34/SCoVlqx4MW/v/XrCVR7yeN1l8T+3ChpJkB28aY6s2E6o+PapA/icT1RhUKj6qz6ZZSHIMrputjD9aXBBjIT39sP7luUw2IrlJSsvq/jTGenovqq3/eMVd1VuZHGRKA6fgfo+ADMF3sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=UURd6zxz; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8Nm0Z9001551;
	Fri, 8 Nov 2024 23:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=m703FlekVZtOtfVI7Hj01ky+0udNH
	XAT47z4lufaX/Y=; b=UURd6zxz9UT6uXh7V02h2LFsxai2RaaW2btuQODv09RVr
	kzW49L1r7O0L7Q05Es1+oyKmmUsp6nIUWrxAs6RrOsX1dSP9yuyLsrSkbcIcNmRE
	TXKhrHNKPOqMXM9syL0SYtF5EfqxYkYutAQKOzASbkl9omp/PK1Ju8TmjGMxmRSp
	C8YLa6DkZnN8SzZhJMisnLoDZ6HkjzpommBpEM9xtw/UT6S9Atupy/0rXBxwqtsB
	GCJst4vIsHTzo+yMd5tLzNNC3pwN6RE1w6uX/ERraW02pSdzRdTYYKWvdnAM9PH/
	nxo+KtXGyF8hKk19mZzHXZ63HHcjUulxBO7G9HoqQ==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 42s6f7h17p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Nov 2024 23:47:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBaw2Efgw1EvsxRm6odczu5Bc/IaasU0PJWnU+R0yWrxflS7psBlNfLBdnxr7MPHhj2mhuWQeErJxtchfdoPBp+MEEzHz9YOiDP55caF9vOCnN6V9lTNfuEAgR4Kf6dvKYlKdO5xR80OT8EI4mZuUIh0LQnyd0VrXzM/f2Iatngsjbj+gQc9kxqD9keihl9OvsC7i6MCIyCAdwLNzMqdOf0TV0ILjnEIFcHjl1R9otkF6gxcPlkIkbWf8hLH+NG990p6qWm4nqATEf6GO2FJyYJlawIMDTUOPIhOTSbLN0SzMYRDRgkt4Hf9JlHENwO2ImgV1hO7HqhZNfWMiaWpww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m703FlekVZtOtfVI7Hj01ky+0udNHXAT47z4lufaX/Y=;
 b=trCQyZSXhiidSIR728XESAfmUHFmzcsglBXbTk2cCOzAMObpnjI2XPjmAwpyKQFsBzZgFRgikK3pAQ6eNfMk2KaOQGSltnxDMqa99pMgITOL4sY2EvSj8Yrz5cLSjet+Ouey+3+n6H4129AUvs6EpcvcCZ8qcwL26L/kNeIOBkm98YxOb43CZEuCMHGtA7mRGAIDAVdn93gCufef4it6W42MMa8EEqrsYK7KlvyDvRIVqA4H7EyQYm06DUIIikuZB1sN/O6qXOZ0yMiTqLQaZqZuRUWENzei53Qg5t7FDKevsXdoF2DMUDlGXb59nFHR/SL7zoPfp20Vok/7CyEgqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from MW5PR13MB5632.namprd13.prod.outlook.com (2603:10b6:303:197::16)
 by MW5PR13MB5631.namprd13.prod.outlook.com (2603:10b6:303:196::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 23:47:53 +0000
Received: from MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197]) by MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197%6]) with mapi id 15.20.8137.021; Fri, 8 Nov 2024
 23:47:53 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: "linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [boot-time] SIG organizing meeting
Thread-Topic: [boot-time] SIG organizing meeting
Thread-Index: AdsyNUUDzZQ/3++gT1+/YcIfOX+G7Q==
Date: Fri, 8 Nov 2024 23:47:53 +0000
Message-ID:
 <MW5PR13MB5632D59CC8D54682BE6EA092FD5D2@MW5PR13MB5632.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR13MB5632:EE_|MW5PR13MB5631:EE_
x-ms-office365-filtering-correlation-id: 623e6204-9f25-4d39-7cf5-08dd004fc32c
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0Fts+WVNJ1b1zOkoMzvnyJBeakOsvflpdzyU0/hnHDK8u0XBCU00fk2FlX1f?=
 =?us-ascii?Q?DIyh+6kRNvMl4wIG9Vx11lDjlfoU9/pXG4AS0V3AyRq2msy7M5SOEgm8AKPC?=
 =?us-ascii?Q?amsN7MdFG5bEO2FKn1DhKxu+jUepLHg/12EY3ATOCdtnQjDaSYpYwXWLesJz?=
 =?us-ascii?Q?hIAN7af0V0qjPdQgVNOh37jwXeUL0uDV7Z4F8+nkQNag8JLW6KY106n0bvVD?=
 =?us-ascii?Q?iLOUO18PTQBcN70vrX2E3CorM0PsudRIcxD/y/YFM96Gbz9dr0MGAB5qgm+d?=
 =?us-ascii?Q?p9z4cEwX4u4rN2dQSsWMBWzD1EQTP+mHi4DYqqEsjtYqqtLdfgJblLblo6pZ?=
 =?us-ascii?Q?AmiLMCMC5sPr/EpVz9B3HjxDJy2Fyg7+WjJSKyFW0G2jsm+Yq6ggHZNYDX9e?=
 =?us-ascii?Q?l0CmLf9y+qIcypwJ6y7cXF/QPgmcgR7U7l8SFwi8uWD0PYU78gu2yVirGiQN?=
 =?us-ascii?Q?Sgi6P2RQIQ1oc9QJWmrK3g4atoa/mDrtM8gwAdCDYkXdQiBJtanBB/qVXBOV?=
 =?us-ascii?Q?cpWnWTjpzlgW61A1eBEJtFrcXun/s5984OYjb7Hd/lbc8cO9tk8XY8MCDdly?=
 =?us-ascii?Q?pA9fNOQCWetEwEr2829rXwodyT4y7wh6erv5sEVJkkE1rqjSgmX6d8TkPlkE?=
 =?us-ascii?Q?t5skmA+RBxzJWMZmEkQdexTFiXVWHFgXGRHFA2vWo2YrhqDDlWVzxh+uONMi?=
 =?us-ascii?Q?puo5fLl4Bacd7EkudLv3ynPRRdimt23JH2LGHWJZ1RGUhmUOHOX5KDYY8qrs?=
 =?us-ascii?Q?yQhWuLMcX30abi16C/GcDNwWcq2pavRFMHhQSVJMm9yl7uF1EQGhUBxlmfWD?=
 =?us-ascii?Q?TSwAUHyzz8lygxK2ggOSyJqkGSykmxoAY3ZNdQNWvLnMgJEQwEE5S4nw71qT?=
 =?us-ascii?Q?qGXLzw83Sgn7zAKrAIZwyWuCHGdDjcms9e6fq7sIC06iS0k0+rZulg0KUrIJ?=
 =?us-ascii?Q?9l5u48v++Gix/7HcK36acqjxUxDQ3dpFXee7LLPvratlQ7kUDIDb7DhI6DPG?=
 =?us-ascii?Q?Sx3eZI/jzyzt/VV1mbD34g8JA0bXY022iOnlqnPdDJQE+D8GgxkGnox1gWsm?=
 =?us-ascii?Q?ll/3Nib5CidT1IwlbhtRv2+8xvLKxjL+p4G/tXF4hyuTed3u5pzXgsSIUycP?=
 =?us-ascii?Q?e6qEsYOH9HID37h5xPfiY386bBrwwCW5NHQCE2JMQigALbTziOnFdyrQV/S+?=
 =?us-ascii?Q?2Rrnk2v/juchVxL0HcDnDZXi4ydrb1uRLH2RwFxcc5zXjPT5gz0ylo64cS3R?=
 =?us-ascii?Q?p7ZEuK8FQRhofpBnaM1hanuHv+dI4OYSXCDxLUN9haMGsCJ4WENsE/1q3ATB?=
 =?us-ascii?Q?CaihA8i5nsefS9JeufJh5gLcWlzN9vFQMqMxfr2qZD0SSK8bBDsqmzMO3XdL?=
 =?us-ascii?Q?zmP9mHQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR13MB5632.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MMKlUHcY8FeS9D12tf1VZFOMqWGv1dZjCV20fN+TL7+X8LcDDQzi7N/MiN/E?=
 =?us-ascii?Q?vLQzS5MtN7Ezqm4f4TM4a0SK3rON/aklhPTrOERWvR8MJFa10T8TNSIhWf81?=
 =?us-ascii?Q?xQtLnYbLJh5JsFgJ/mKcOO4RDRpBtb2svOVps3PTJ8HdJvBM7O59HMLoYuV9?=
 =?us-ascii?Q?V6iFAiKdNanUTVr7GcbzvuIeXHwTWh5c8fVnDz04wsTJholeVHLztN1knvmF?=
 =?us-ascii?Q?7EgfMqNeZFvbngHAh4/kTHcvB9bDrW87ufJbouVgYEsbqPejfWtSI7U3JZrc?=
 =?us-ascii?Q?XCEYjYF1piRMNLqTZ4BAKNVysN0jKqpjAkWh3hmiwUNm8fDkZBxZmqZVRFl9?=
 =?us-ascii?Q?bEajJRfa4p4ZrUeuFGfMCXFB6zyHo5yD9PkQHwoBQIfRyC6/litLb5d5irtj?=
 =?us-ascii?Q?34TgLZW3OHHj5JgAuCPKORcXjj2mtq+2cK11vOMy3CrnAjfeGuR0zdmWKUNq?=
 =?us-ascii?Q?oa49HNwumxZo2j+kaa1uVSLTEMWEGNvCgNxUpYq7ZgSpKaewFukYzN6K9A26?=
 =?us-ascii?Q?cRNGC+hkLt3JUrshBw3jSXS0lsWmnWLgikj5p7yy2l7QUYBzMNiR99VYBc2O?=
 =?us-ascii?Q?wIzH97dI22Ct+4Tu6uyV70CPtJMjOxvTCZcDEMIyVtq3PDJg3vC4y4sec7dI?=
 =?us-ascii?Q?tcjK3cPHzO33n2MHKTtYNoFtqOQtkTy7QERvr5lyA4LeplPivb4dlVStxhAd?=
 =?us-ascii?Q?06Uh7FfRSfVTlXgcfbPjvcMc5X+kw+DgBy8SOLxLav09d7P91LspVG7d70Xs?=
 =?us-ascii?Q?PzVICazhjVTP8OXHfWaWdnwuTS+WFJxXfV3aiGmvc3jwA3edm2ZZs7CDqgvc?=
 =?us-ascii?Q?dsuzfwATyz6a9QApuEVjKonRbOmeh+rvGDUyhoRTBCa/0GB3s5k50F5LLM92?=
 =?us-ascii?Q?yOu+QFSMguCKx6pbaNEpx6Isg/P0jcjowheneNwhd7JZ4z7srTMghrwOIRZ7?=
 =?us-ascii?Q?pRYFA1KRDDZUZb9c9EGIHA2adVLfeH4ofpn++/pvG7+WQIIZdpDaz+gdWeng?=
 =?us-ascii?Q?89dkofb9aWVXD0iSIwdRCRbnAX6kNxZHJto45dDczhc6A7L+AyHibBwex1Ur?=
 =?us-ascii?Q?JXCa9RF9dor2TxRxsZCA/O6Ci1wzgT0HMxRtkPRTNw3l1f77XyLkR6669PVZ?=
 =?us-ascii?Q?1/CiNNBJQ9jOFoYQv6o9zOC64FPrWK+Pm5RupzPloraYLew/8y16qZTlG3H5?=
 =?us-ascii?Q?nYAQQIqd4+vYBy+orIQtbnnjhEOLU4wqipSLOpRlVxMoawX4bB17IR4vcDL9?=
 =?us-ascii?Q?CM627AyEhPjRJKhXiA5eCvkxnKZSW1c5/ZqeP3WccBQkn5fV+yTZlW+dO+kS?=
 =?us-ascii?Q?79HwMv9CWf5zkGH6rLq2oUcD+y+oDiCp/QXhzgmgwOyi4Hsyicfq0kFFvHeU?=
 =?us-ascii?Q?rNTJpZ/BT0vQ5OTD26wMZG4c+HE6Hvd36JdHainiQrV+nwoYFZ100uL5jocX?=
 =?us-ascii?Q?6+PHPSRgew0ywR3PQJmQZevEsyGn0r91bmaXPbTjiCV14IL7Mkmt8DJijq9B?=
 =?us-ascii?Q?FbXUsky14Fv80x5ue8PHwWnNgseoP7W2i+sMvon5gMfWf9ltB1pSYGuylPHm?=
 =?us-ascii?Q?d3aVVhbJ63Xo2Zp0WUQ=3D?=
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
	YK/KVIHEDmXzgHta7EmLXVcC13NkynMAfYpTWGxU994nMpOm8ZCAZoGSQPVtgoXl4EtyHNRtXbmQXAMKym1a1MhPPB+7PvU8X7wKJAJKrMhrk2s8yy6up2DQIQgzc0TnzMKgAt92G8f6ki3k31vTnAEJSpE9YX3Ztc1l6cJxcdCF42Kkh1bFnLgpSsrtG/BBHIBRIveGZL59LfLYV1Xqr183e3j2F1gYTD0GtQr9Q2tqO6o39WZ+x9FQhVvCUDB2hI6lAaAjQ1cZYKlRvZ8YW7VR/x4b5Sb1ag95JrnUX6ng5PPJzs5qEv6kZirp+SQba5JmvE++w6/EvhB9zhh3TL1uPN6hV/XuGmwOAqGJwfL3rZnfb9efpau7V1WlisMyd36OE0oE57kevvzH3jYDO0IZNNLgwoiEQAwq0pDv5Ou5zud7KMmeu85efy/Zv+HRNaP4e4C3sKdr9ZCL/8tURY3lSzuuxSOTpT6i+mzDQRLJcyQcT5SdtEqmU4EIZ28ug5sJuCR9ufIaZ6J1Tl7a3Pu8oXSuYK+wzEllawBDmnBUtS9ZRx7Od8EzAqZqud9reS5oYUr/ng/YHKtPfbwQ+SnhO7Fm7zHMSotbxiNgKck11DUwA5DeTBdRNGhlciX6
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR13MB5632.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 623e6204-9f25-4d39-7cf5-08dd004fc32c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 23:47:53.2904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cDmGiMmdWT/eiOEl4/6ct4uQGPeaCABFx2gdQXIybicPsG3Wz3iiW7ywy/BtcPfNII9nto4NiB94vvGQBQfmjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR13MB5631
X-Proofpoint-GUID: 60D0OcJyRdXAaYz_DLsnPTRQ3_6giMdX
X-Proofpoint-ORIG-GUID: 60D0OcJyRdXAaYz_DLsnPTRQ3_6giMdX
X-Sony-Outbound-GUID: 60D0OcJyRdXAaYz_DLsnPTRQ3_6giMdX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-08_20,2024-11-08_01,2024-09-30_01

Hello fellow embedded Linux developers,

It's about time to plan our first meeting of the Linux boot-time SIG (Speci=
al Interest Group).
Things have been very loosely organized as I've been trying to gauge intere=
st
in the SIG, and put forth some ideas around Linux boot-time to this list.

Unfortunately, I'll be traveling the next few weeks, so the earliest I can =
put something
together is the week of November 25th.  I appears that people who have cont=
acted
me with interest in the SIG are primarily from the US and Europe, and maybe=
 India.
(It's hard to tell just from e-mails).  Therefore I propose some kind of vi=
deo-conference
at 9:00 am Mountain Time (I'm in that time zone) on Tuesday, November 26th.
That makes it 8:00 am Pacific, 5:00 pm CET, and 9:30 pm IST.  Not great, bu=
t possibly OK.

The agenda would include a number of things, including:
 - governance of the SIG
 - projects to pursue
 - frequency of meetings
 - what resources to use
 - where to put things (besides (obviously) upstream)
 - how to collaborate, etc.

This is not a traditional trade association or funded project startup, so t=
here
won't be any memberships (with fees, tiers, voting rights, etc.).  But I st=
ill
think there should be some designated leadership and resources that will
be available for the SIG to use.

If I had my way, I'd use one of the Plumbers hack rooms for the meeting,
but there are details for access to that, that I need to work out.  If anyo=
ne
can volunteer to provide the video conference hosting for the first SIG mee=
ting,
please contact me privately.  (Otherwise, it might be Teams, which is what =
I have.)

Please let me know any feedback you have on these plans.  If you have a str=
ong
idea that you would like to attend the meeting, you can ping me privately t=
o
let me know your interest.  (Fair warning - I'll be looking for volunteers =
for some
tasks, so if you are easily talked into Open Source work, consider your
attendance carefully.  That said, lurkers are welcome also.)

A few other thoughts...
I've been a little wary about how much to copy LKML on these messages.
Usually, most of the kernel mailing lists are highly focused on technical
discussions and patch reviews.  This SIG management stuff is neither of
those, and I don't want to unduly burden the kernel lists with this type
of material.  To that end, I will probably stop CC-ing LKML on this type
of administrative e-mail.  Also, it may be appropriate to get a separate
email list or communication channel for SIG-related conversations (ie
discussions unrelated to kernel features.)  Let me know what you think.

Regards,
 -- Tim



