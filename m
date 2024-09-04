Return-Path: <linux-kernel+bounces-315712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4A396C61B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4093B237DA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C08E1E1A2E;
	Wed,  4 Sep 2024 18:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="HL2fk9Td";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="X1yETFKX"
Received: from mail-edgeMUC221.fraunhofer.de (mail-edgemuc221.fraunhofer.de [192.102.154.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10CB1E133F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 18:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.102.154.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725473645; cv=fail; b=Cxgi6fo1eu/SzAp2WjHnffa53xAXnlPR6mpNoGsZNBSVZvxpCdQ15yyp/EJVzi4bDBtQdJf0pQ2Dak3RjhKw4wWTyo5W/vo5RrJ9c9u8S4qTd9ZFdvVQHZ72/pVLCIneOyK0gl/FM7EOr0xXf/0cepTRdiMcaaQbwhHYAe5SFXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725473645; c=relaxed/simple;
	bh=I/12fuf7tb/VME9lxBYWpC/kJnKFDOnYLE05yqwOPPg=;
	h=From:To:CC:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VdbV12GqFk86bTGtt17AP+EPda1dyqwZ/BwylyC1XoUJa1JzRGFiVyGE+4oMZzk862TEK7nxDjDndejZ0OIw7hdT7pCJwzpUD2OnTUj5Hk6rd4EVKBgSCaJyvQlBOZ5w+LhpnHuVyrGsM4QLqYsGx04uOmTx7Sxnzc5JsDjcxW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aisec.fraunhofer.de; spf=pass smtp.mailfrom=aisec.fraunhofer.de; dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b=HL2fk9Td; dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b=X1yETFKX; arc=fail smtp.client-ip=192.102.154.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1725473639; x=1757009639;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=I/12fuf7tb/VME9lxBYWpC/kJnKFDOnYLE05yqwOPPg=;
  b=HL2fk9TdQCXKJjBY8PY3p9ZRqulTOOhLbp/62wI/noTT1ahgbxuLMZfA
   bDwoaDoZUHhRt5w6+exgMrm4LuzJ1+ZQACd4wlSKQI4F9G516aLZWvWNJ
   1Aze0rDIL3vcVoGoLiSA1EvSiwXsddSuz0PedPuHnTTdALJPpD40gZg2u
   bqLw5oq/2RzKjpzCPhNKrcaNmjv1DFwX4GsigySj0FUIZ+bMN9vg2o85v
   eUhxKwOwwRp1cj7Fq+FzKa3banAVNzaRHf5sAFACAQ2kn4vyYG/ZZu0iD
   yFDazjVKL+xcophVYt3Ri3hUkrQ6jMQGKp8PuFefTuqx9MbEbzmuzKavp
   w==;
X-CSE-ConnectionGUID: Lktu/WrXRuqfwfFm/A1//A==
X-CSE-MsgGUID: T2pWJjG6TvSg67i0VcbliA==
Authentication-Results: mail-edgeMUC221.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2ElBADhodhm/8ejZsBagQmBT4JEcIFxhBo8ri4qgSyBJ?=
 =?us-ascii?q?QNWDwEBAQEBAQEBAQgBRAQBAQMEhQCJeSc2Bw4BAgEDAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QEBAQUBAQYBAQEBAQEGBwKBHYUvRg2EBoEmAQEBAQEBAQEBAQEBHQI1aBcPA?=
 =?us-ascii?q?Q0BATcBGBAMAiYCMysBDQWDAIIxAzGRfZw2gTKBAYIMAQEG2yQYgSSBIAkJA?=
 =?us-ascii?q?YEQLoN7hFABhHaBK4cJgRU1YoFib4QKToNGgmmHdIwviUgXJYldjTdIgQUcA?=
 =?us-ascii?q?1khEwFVEw0KCwkFiT2DKSmBa4EignWCTgKCV4FnCWGHaGeBCC2BEYEfO0aBP?=
 =?us-ascii?q?YE3SySFL4ECglZsTjwCDQI3gi4lboJigRwdQAMLGA1IESw1Bg4bQwFuB6obg?=
 =?us-ascii?q?mR7E5YCswoHgjaBYqE6GjOXTJJ4AZhxIqQRhDwCBAIEBQIPCIFuDIIDMz6DN?=
 =?us-ascii?q?lIZD44tFhaDQs4CdgI5AgcBCgEBAwmCOYh9gX8BAQ?=
IronPort-PHdr: A9a23:JYxGxBbR2BtlZ9iMkgbhAyT/LTF90YqcDmcuAucPlecXIeyqqo75N
 QnE5fw30QGaFY6O8f9Agvrbv+f6VGgJ8ZuN4xVgOJAZWQUMlMMWmAItGoiCD0j6J+TtdCs0A
 IJJU1o2t2ruKkVRFc3iYEeI53Oo5CMUGhLxOBAwIeLwG4XIiN+w2fz38JrWMGAqzDroT6l1K
 UeapBnc5PILi4lvIbpj7xbSuXJHdqF36TFDIlSPkhDgo/uh5JMx1gV1lrcf+tRbUKL8LZR9a
 IcdISQtM2kz68CujhTFQQaVz1c3UmgdkUktYUDP7ETnWYfQlijLr9pG9XSWDPLzavMSdBeQ8
 71ieiHtsh0AC2E3zE+L1MUrgaFE9UHExVR1lr6NcaypGtlOWa7ZV90/FEhhZNZfdC5uDKKdf
 5oXIvcbJ8hSj4zm92E2kSH5Xi++WsXswxVLnkHs3r0f08liGljv21YqMsocvWjIoOr8EI0Wd
 7jq7bDqwC77Nfl24jDA1JnKXh0fns+2VpBMc43w0GwtN1vmllyCrsv0Mwy4zNs8jkKDxs8jf
 7OdhykrrSF2/T2C+MZ1yYXq36I6ywnH5R5IkZoLCIGqcnBqRIv3WIsVtjudMZNxWN9nWWxzp
 SImn6UPooXoFMBr4JEuxhqaZvCIfq21yUi5DaCfOz5lgnJidr+lwRq/ogCsyez5A9G9y00C7
 jFEnd/Fqm0X2lTN59KGRPpw8gbp2TuG2w3JrOARCU4unLfdK5kvz6R2kZwWsE/ZGTTxllmwh
 6iTHng=
X-Talos-CUID: =?us-ascii?q?9a23=3AmEt4KmobiicxOGQgzztUndnmUeQmbmCa823gGVK?=
 =?us-ascii?q?hB3lnZrjSYAbXv4oxxg=3D=3D?=
X-Talos-MUID: 9a23:8Om52Ap3Bu8Os3VNHkUezw04LPhK4YvwNF42nstZupG6PiZ0Oh7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.10,202,1719871200"; 
   d="scan'208";a="3613646"
Received: from mail-mtabi199.fraunhofer.de ([192.102.163.199])
  by mail-edgeMUC221.fraunhofer.de with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 04 Sep 2024 20:12:46 +0200
X-CSE-ConnectionGUID: /y2DIyJqTH2txP/XqPYyPQ==
X-CSE-MsgGUID: D423OslyS2yICm3w7tfXFg==
IronPort-SDR: 66d8a31d_w7avVQmNvMvF5PUT1T0x2eiokPL/6+Vi/S3mahLxyvmlthQ
 FsmvUps0aYvhAuba84kNeXAduH0v4j+gk+H7Cnw==
X-IPAS-Result: =?us-ascii?q?A0CQBABMothm/3+zYZlaHAEBAQEBAQcBARIBAQQEAQFAC?=
 =?us-ascii?q?RyBGAUBAQsBgXFSBz4raYEIhBk8g00BAYUthlGCXAGcLoEsgSUDVg8BAwEBA?=
 =?us-ascii?q?QEBCAFEBAEBhQeJdgInNgcOAQIBAQIBAQEBAwIDAQEBAQEBAQEBBQEBBQEBA?=
 =?us-ascii?q?QIBAQYFgQ4ThXUNhlwQBhEPAQ0BARQjARgQDAImAjMHJAENBSKCXoIxAzECA?=
 =?us-ascii?q?gKRd49RAYFAAosigTKBAYIMAQEGBATbHBiBJIEgCQkBgRAuAYN6hFABhHaBK?=
 =?us-ascii?q?4cJgRU1YoFib4QKhBSCaYd0jC+JSBcliV2NN0iBBRwDWSETAVUTDQoLCQWJP?=
 =?us-ascii?q?YMpKYFrgSKCdYJOAoJXgWcJYYdoZ4EILYERgR87RoE9gTdLJIUvgQKCVmxOP?=
 =?us-ascii?q?AINAjeCLiVugmKBHB1AAwsYDUgRLDUGDhtDAW4HqhuCZHsTlgKzCgeCNoFio?=
 =?us-ascii?q?ToaM5dMkngBmHEipBGEPAIEAgQFAg8BAQaBbgwpgVkzPoM2TwMZD44hDBYWg?=
 =?us-ascii?q?0LOAkMzAjkCBwEKAQEDCYI5iH2BfQEB?=
IronPort-PHdr: A9a23:YKC5BBZLnuZZNFgVXbbpfbj/LTF/0YqcDmcuAucPlecXIeyqqo75N
 QnE5fw30QGaFY6O8f9Agvrbv+f6VGgJ8ZuN4xVgOJAZWQUMlMMWmAItGoiCD0j6J+TtdCs0A
 IJJU1o2t2ruKkVRFc3iYEeI53Oo5CMUGhLxOBAwIeLwG4XIiN+w2fz38JrWMGAqzDroT6l1K
 UeapBnc5PILi4lvIbpj7xbSuXJHdqF36TFDIlSPkhDgo/uh5JMx1gV1lrcf+tRbUKL8LZR9a
 IcdISQtM2kz68CujhTFQQaVz1c3UmgdkUktYUDP7ETnWYfQlijLr9pG9XSWDPLzavMSdBeQ8
 71ieiHtsh0AC2E3zE+L1MUrgaFE9UHExVR1lr6NcaypGtlOWa7ZV90/FEhhZNZfdC5uDKKdf
 5oXIvcbJ8hSj4zm92E2kSH5Xi++WsXswxVLnkHs3r0f08liGljv21YqMsocvWjIoOr8EI0Wd
 7jq7bDqwC77Nfl24jDA1JnKXh0fns+2VpBMc43w0GwtN1vmllyCrsv0Mwy4zNs8jkKDxs8jf
 7OdhykrrSF2/T2C+MZ1yYXq36I6ywnH5R5IkZoLCIGqcnBqRIv3WIsVtjudMZNxWN9nWWxzp
 SImn6UPooXoFMBr4JEuxhqabuCOWanRs0OlWvyYPDF4g3xoYvSzikX6/Uuhz7jkX9KvmBZRr
 yVDm8XRrH1FyRHJ68aGR/c8tkes0DqCzUbSv8lKO0kpk6rcJZM7hLk2k5sYq0PYGSHq3k7xi
 cer
IronPort-Data: A9a23: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
 DX5oOuq+ssSubEk6MXo3B26K8QQzIffZJYb
IronPort-HdrOrdr: A9a23:02E16ave4R68BcKXuLV+Zs9l7skCgIMji2hC6mlwRA09TyXGra
 +TdaUguSMc1gx9ZJhBo7G90KnpewK5yXcT2/hqAV7CZnichILMFu9fBOTZslvd8kHFh4xgPM
 RbAtdD4aPLfCFHZK/BiWHSebZQo+VvmJrY+ds2pE0dKj2CBZsQijuQXW2gYzBLrUR9dOwE/N
 323Ls1mxOQPVAsKuirDHgMWObO4/XNiZLdeBYDQzoq8hOHgz+E4KPzV0Hw5GZXbxp/hZMZtU
 TVmQ3w4auu99m91x/nzmfWq7BbgsHoxNdvDNGFzuIVNjLvoAC1Y5kJYczKgBkF5MWUrHo6mt
 jFpBkte+x19nPqZ2mw5SDg3gHxuQxenkPK+Bu9uz/OsMb5TDU1B45qnoRCaCbU7EImoZVVzL
 9L93jxjesbMTrw2ADGo/TYXRBjkUS55VA4l/QIsnBZWYwCLJdMsI0k+l9PGptoJlOx1GkeKp
 ggMCjg3ocZTbvDBEqp/1WHgebcFUjbJy32DnTr4aeuonhrdHMQ9Tpr+CVQpAZCyHsHceg12w
 31CNUXqFhwdL5mUUsEPpZ4fSKWMB24ffueChPkHb2gLtBEB07w
X-Talos-CUID: 9a23:Cuq+nGMFF38/mO5DHzg92G8FONkZUifB3E+XE1aAOHdRcejA
X-Talos-MUID: =?us-ascii?q?9a23=3AknVJ/w9DplRjdCTxK6uh5TmQf+s0uf+JE0Qcqs8?=
 =?us-ascii?q?XmuKBbjMvJzmtojviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.10,202,1719871200"; 
   d="scan'208";a="7674823"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaBI199.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 20:12:45 +0200
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Sep 2024 20:12:45 +0200
Received: from BEUP281CU002.outbound.protection.outlook.com (40.93.77.1) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11 via Frontend Transport; Wed, 4 Sep 2024 20:12:45 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufKgURUt75lkTPioTGlfIcbbIqh2yBzl1EASTggoBudx3x0IinVJI7vL6hHXfMW2GVTFMFAyDyCaFVEeKfUE3PG9HQhRnOa/9Rs4IyV4hAlmKriexHDCjsJvsg40cSdyqwEyxNRsZqaetGMyFctEcods1ast7lZaa0HQ+JElLWtMt3TrEbQ6aynY2IrFeUHqJ1SLYrfiw1FMpZJVICJJ8ErvbYZh8cNRATZKmVg/Fc4Q2xbMqEwAIjhgmg+4oik4v4+4garaLAnglgKjJO563bjwb1bebEc63eNrar8mkxKw0hhheY/YrsPP7qXNMduD9cccmjKYPljanoEVKqIHgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoxILkYqXSE5dYWmO+NEKZtraZVmRRoT7fTF46a3ekw=;
 b=f7DqcFwMbjDaKnl7AtHTc7qpZlDUVwzwD+MsNx0hxqkJl0CRhh+4+0/hT6z1q/5UWR22Wu/9islgxGHtDhWZMJPS/i4pUkkeNQGbMQHBEvZ9dgBxW08Xg1eOU18zF1qu9PjTI4WFYLL2DevEMcKnTmrb941KICVTJqoFL6ClWugdmH8+ceMAhvheUT0VrUfG4g1MMOB91S2AbJJJalnxaEMb1dtgqdSv3Mtqjpj0tuZOvjCbutIaY9VS82rWRuvUsBzSPWmctcO4n5cjpsTAN6rWvz7BEmvbyg6ZYJfwBhC7B4yV2kHLAbsBYUHPYa1/EX2ZitBSRU76ugyrw4/TNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoxILkYqXSE5dYWmO+NEKZtraZVmRRoT7fTF46a3ekw=;
 b=X1yETFKXOelBfM9JHRxfKjGfIIxypEurrFbHms8RPTR/3Nz6NkaBkpVrkxMhE+c1Ao2bEpzettdWaLBlN07IqJesP2bHSoUTyjDeVWVRcJTj/IqMjH0Kpazo/ydWErWYUBpAM+B9Zd/dnHo7mEVi1+dK1HGi1kxSY9tVE4zRVyM=
Received: from BE1P281MB2180.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:3f::7) by
 FR4P281MB4301.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:129::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Wed, 4 Sep 2024 18:12:44 +0000
Received: from BE1P281MB2180.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2e9b:1cd6:256e:55ed]) by BE1P281MB2180.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2e9b:1cd6:256e:55ed%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 18:12:43 +0000
From: =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo
	<acme@redhat.com>, Namhyung Kim <namhyung@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <gyroidos@aisec.fraunhofer.de>,
	=?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Subject: [PATCH RESEND] tools lib subcmd: Fixed uninitialized use of variable in parse-options
Date: Wed,  4 Sep 2024 20:12:39 +0200
Message-Id: <20240904181239.873014-1-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::19) To BE1P281MB2180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:3f::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2180:EE_|FR4P281MB4301:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b6be4b4-8365-4a3c-072c-08dccd0d2be6
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDZORDhtQ2JreHJlOWlwSUJWUmpWbFBURXBFbTR5R1NaZnR4a3g2OUpYSlg4?=
 =?utf-8?B?QVFRTE1DdGF0ZXFJK1JXejkwR3JzcGprbjN3M00zUlMyMm5xZkVUcE0yaHM5?=
 =?utf-8?B?ZmZhRVkvdldrWUZwZXR1b09WVHB3eFZsamYvV2QwUytKR0Rza0VEeE5NcDZL?=
 =?utf-8?B?OGxxODg1ZGVOdkpNUUNJUWF1OUFSLzZqblFOOVlOQm5RRTNzT0hySFhlUUVY?=
 =?utf-8?B?blU3alFhZXpwVVRlT0J5SDRFcUROT0RWTEdkbEVIT1NTaVJLWTlWN21lQndo?=
 =?utf-8?B?cWt1WHNqMTJTSG9TNk1lZUZqYlhsOWlVdVdpTnR6VjhqZnB3N2p0dUo4ekJT?=
 =?utf-8?B?QTFsa1U0Vm5IZmRHV2V1R3ZoTldlY2xkNWRLaWdJUVovYitZWTVrQmk3NkhC?=
 =?utf-8?B?bUc2ZzZHdHAyOWRNUk5PWkx4ZGh4a2R6WXJrWnFEM1BXSkJoVVprQ0xydlNp?=
 =?utf-8?B?ZXlvT25RNG5adXo0SEtwaE0yQTB5VDFYUUczS1dueW5yekt5cERYNjZCSFBj?=
 =?utf-8?B?Zm5VZG1xSzFPdmxGNlBqVmxTUGxCU3ZNSThKd0lGN0s1RkRlb2M3OFRTYzBh?=
 =?utf-8?B?WE9BK2JpYTZiV3pJOGFRM3NvQ2hSU0hyS29Rdm1hR3dOOFV1bkNrdy90OGgr?=
 =?utf-8?B?NE44TjlCeHlpbzM0VUw1VVBZSzF4aitxcTRDSUhHUUZXQVZBZHhJbm94SW93?=
 =?utf-8?B?RDFlSWNrSFFxTHhFOEVhdzRDcm5rcWdQY0xzQmNYVUZDOUxiQ2Z0TVpEaE9I?=
 =?utf-8?B?NWlWaU5ncWh0UlVlL2Z2UkxLNHVYVlk0aGVocnR0bkFuVWhwZGhOSlhITW1U?=
 =?utf-8?B?d3l0S3hjZ04waUJOclFaYStMUEVmL3VsZVh2SzhpbDZmUjVYSW9EMG54MEFa?=
 =?utf-8?B?Y0FNYlE5NDdOazcvdjY0allQNFkwS05HTEREZFlqb0FkZ0xveThkMTM1Uk1V?=
 =?utf-8?B?MSs2SjhZdUZ3eWM4VkJCcVlQajJZUHB3eFZ6N1hBRmUzOHFDNXl2djhmTmVE?=
 =?utf-8?B?UmJhQUw0KytONWQvYVZVTjBvaVF6K1VYRjVHYXZKb1R6NUhJOUViZWdjdmVr?=
 =?utf-8?B?U0xxeGVnbFhWVXlGVVE0WURvb0owd3RkY1Q3MEFlRzZNVk4wSkUwNURpNnMz?=
 =?utf-8?B?UnF3UnhnSDhLOHZKZkNXejMwYitKZ2FhbklwbW1ETXFCMFljQis0d3B1bklm?=
 =?utf-8?B?RUlsWnNVbVdZTXd3d2xLYVcwN3JzZlBXejZva2hpakFwN3UrT1E3dmx2TFh2?=
 =?utf-8?B?L2Z3VWc0dmNWbE5mejl3MmlLWHdNQk1ZZ1QzRXc2c3RNYUF5QnZYbWpoTDdv?=
 =?utf-8?B?UWwwaTl6NVc5dWxkb0NtRWZyYzZhbk5ZVzZOR1RZbWM5aHhWd3p6bXdiWktN?=
 =?utf-8?B?cHhKTWNDdFNZUTRaZHJqT3gzb013WlRLRTlYdDRsVjltdGdLbnErdFhXVUl4?=
 =?utf-8?B?MkRhZVk4RVZLbStMemR5RGsvZVdWaWdIU3JWUU8zTGl1ZkpDN2pLaUhJL04y?=
 =?utf-8?B?eVl4WnZ3QzBIdVhiRTVXYzhlVmZISTNvbnlITHEzODk5Y2pxZTNueHhZT1FT?=
 =?utf-8?B?UXpISU8xbVlhY0FqbVU1SFhoQlhxSXp2TGlpV2JNZHlUVTBRM1RUZmFNczlN?=
 =?utf-8?B?TXc1MVFTbjhybHgxRVdkeWl0YnJIUXkrenVDV3djWlArVXg1NWNFK2d5dXpv?=
 =?utf-8?B?ck9sSWNpWjNUL0x2YTJEejFjTjZqaGZmanpQbWhtWVVHeXZlMEdLYW8xWmhj?=
 =?utf-8?B?SWxNdmdsbkcwekNFK0N2MFpDWDFFKzIwaWhQK0l5ZmlJTEo2d1JFaUlIRFpm?=
 =?utf-8?B?LzJZamZ4SFZiUzA0UXFrUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2180.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFJBVzIweUFQanIwNXN6VnBkNkJZZUZJdzRvcFIwL3JPSG9aa1ZXa2JHd1Rw?=
 =?utf-8?B?NncrWEN1YnlFd093cmN4aEZGRFhUOTUweHlnYm5HZTJDN3REUnFUTVFRbWJy?=
 =?utf-8?B?cFh5QXc5bGpQTWY0eWx6Mjd0TTQrSHZ4ZmR3c3dYV3hGL21lOGcwMmd6bSsw?=
 =?utf-8?B?bCtjOEpWd1pJLzIwcmI4SFRJQThtTWdDdFRDOUZTcHdrcXNmVWxjMG05ci9l?=
 =?utf-8?B?S1ZIL0VFdzIzMGVjU0tUd214cGxUUnUwaHZDSi9jdXYvblhSalAxQzI5Q081?=
 =?utf-8?B?L0FLdDRMMk9icXZLRm1FQVM4SUZOWlIvanhDaExoQU1MdmlKZzljci92UGJR?=
 =?utf-8?B?b1VIb1lQUUI3ZkVONDdtUVdvLzJENU8vMzlOaGtXTlIyYXc0MU1aMnFtRGQw?=
 =?utf-8?B?Z0FGZ3pJbnN6SlBiMkk0c3IrUkNBUnhIQm9Pcm1PdExwdnRtVXA4MkJYTFlw?=
 =?utf-8?B?bklOVmg2TFlLU3BkdkRNL2hPMUlQaVpTT2xHNXY3WWxlZjgrUlVmL0lqS1Nq?=
 =?utf-8?B?VXBJTGlqdnIxTjlieENjbTZEaUhyS1NCVUgzdms1ZmRzblloTEFzZmpXUVlV?=
 =?utf-8?B?T2J6M3M3VS9vWjBaMUZDUy9Hb2NyL0F5dXNkSU9nYnhpZWpzZnZZL0VHUXBZ?=
 =?utf-8?B?dzQxSUdqMjZCZG9jSnVJSWpVZjZHWjVWMitVRjNOcjVpaWNEc1JRS1ZUMEZn?=
 =?utf-8?B?QldCblAxNmtZdzJINlVkOFRpeWNkenRPSkFaclJIN3prcEhzTCtmUVBxMDhv?=
 =?utf-8?B?c0Q5dWNnNzNUeUQ3R1BtaHNiYjhCeE9DQktCQ1NISUVSWWRreWJ2OXg0dzFF?=
 =?utf-8?B?MnA4d3RZUkpQVlBKVkdlN3Nlb3lyYlhoLzF5Q0xJb3NDMUkxbnhRZ0d1UEdC?=
 =?utf-8?B?TEZJSkdpYVM3K2E1QWJ1bVExZTJBNFpWZnEzMzJCUG5DUjRKMjM3MmJscHlw?=
 =?utf-8?B?UTBSekxtS2hMWWZ2TStXbFphK0hCUHhDckJBTTRzSUNUSmVBVjRkQ0pWam9T?=
 =?utf-8?B?M3diUXJIeVVzYkIrTW91MVFEZm00SUlXa2NYOHRpK05IemxuQkc0QlI2elg3?=
 =?utf-8?B?T0xTTk9PMFNuMlQydkVyd2ZkRlhuTnhSQmpkK1QrZWZiOExOWENBb3g0ZkUx?=
 =?utf-8?B?aitXeFl1VlhRS2xRNXRncWNrSmZKYUVqczJlcGQxTDFZZHZlTk1CaUFsZmlU?=
 =?utf-8?B?Sys3MXF4dU13YnlEYmtkcUxLZ00venJ5VmRnMGY3eGxDYzhCNldGSnJlMzNQ?=
 =?utf-8?B?ODZpcVNtcHF3akhUK29Pak9wSU1aS1k4N2FDbUp4aVBQOENDT2hkZ3U1bTJq?=
 =?utf-8?B?ZnN5Vi93NmpvZWZHUXFhL0RWWkJ3THVsNVoxd1kyM0dEZWRFQ3VvSFJwdHAy?=
 =?utf-8?B?STIwSzZLOWJka0RrbFF4UTg5bnpLWHduSWxJUUd5M3NvanFhNW5tTm9DdWNw?=
 =?utf-8?B?TEJtRXlyNE5rVnVpSnNPeE5nT1cvRFQ0STJETUFQR1BYcWVHaWhZellQZ0N2?=
 =?utf-8?B?RDJLM3BGclY1MU5LaEJadityNGlHRzNlWk9YT2FFSWdpa2ZCNWZRSFhtb3VD?=
 =?utf-8?B?M0EyMVZ5RGtEMXd0UUJWUlRzODVPUGE3OThiOXFhUVErZzRUZE5FTDN0UldY?=
 =?utf-8?B?WWhUdk5keUpNbHNKdy8xc0ZockNUM3JUN1lxNC80TlYyMnhxbkFWNHdDdzFD?=
 =?utf-8?B?dGxjeXRJZ1RXekZsSU82SmgyWmc4dkhla0JkdGpRNnVYdjE2ZnFCd0pPNUVJ?=
 =?utf-8?B?ZUppVjNjeGlqaEkzYVAvc3JYQkR3QzNOU1NWUEZ4am9DSVNGRzZPeU9Iek04?=
 =?utf-8?B?YXZ6eVl3Vmw1TnVhL1ByRlFtVFJKM01abGhZS0VGb0YrWjV6MWwrek9sZGJM?=
 =?utf-8?B?MENXUms4eUZFYUNaTlcxOXY3L0htWkhQLy9OMWxKbGZQTE51L0FBNGdhYS9X?=
 =?utf-8?B?TThhQ2cvNUtQK08vYU5QOXUyZnBudjZSUndveXF2VHZyUEMzaDJlaWExL0Zi?=
 =?utf-8?B?TExyMDErNDVyZzl0SVhMSExTS2lWaFFXUnBIU0VsVlpqdnB3bjZuSWtabnlz?=
 =?utf-8?B?UUZjMm9NaVJYeDBhdWxxck5ESkR2QmxBaE95UHppM1lGbFZ2S3doOHFRdTNC?=
 =?utf-8?B?aHo1bVJzTy9Jb1JZQjFUZnNRdFdIYlNvZk5laGpaaUpieFZYTzF4NldLNmFh?=
 =?utf-8?B?ZkxqU01kaHczbGV0cGhWNTNOWnBzNHZkb3hJbGxGditmRW5CVEJEMjlQU1p1?=
 =?utf-8?Q?tm28RmdWE7TqhqK9tbVTLcvL2nJZ9iCCHTZAWiquNE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6be4b4-8365-4a3c-072c-08dccd0d2be6
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2180.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 18:12:43.6076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SA4GsdNpqJytnqO6Dia0I5wSLLgjDDDUXPwq684xbSjJxZSjdA/dW5occjz2ysWF67ArY68Rab78K5HjONbExUlMx507giZ6dtTOwKYlFLcf5m9+dFqKs+zd/MP87h3F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB4301
X-OriginatorOrg: aisec.fraunhofer.de

Since commit ea558c86248b ("tools lib subcmd: Show parent options in
help"), our debug images fail to build.

For our Yocto-based GyroidOS, we build debug images with debugging enabled
for all binaries including the kernel. Yocto passes the corresponding gcc
option "-Og" also to the kernel HOSTCFLAGS. This results in the following
build error:

  parse-options.c: In function ‘options__order’:
  parse-options.c:834:9: error: ‘o’ may be used uninitialized [-Werror=maybe-uninitialized]
    834 |         memcpy(&ordered[nr_opts], o, sizeof(*o));
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  parse-options.c:812:30: note: ‘o’ was declared here
    812 |         const struct option *o, *p = opts;
        |                              ^
  ..

Fix it by initializing 'o' instead of 'p' in the above failing line 812.
'p' is initialized afterwards in the following for-loop anyway.
I think that was the intention of the commit ea558c86248b ("tools lib
subcmd: Show parent options in help") in the first place.

Fixes: ea558c86248b ("tools lib subcmd: Show parent options in help")
Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 tools/lib/subcmd/parse-options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index 4b60ec03b0bb..2a3b51a690c7 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -809,7 +809,7 @@ static int option__cmp(const void *va, const void *vb)
 static struct option *options__order(const struct option *opts)
 {
 	int nr_opts = 0, nr_group = 0, nr_parent = 0, len;
-	const struct option *o, *p = opts;
+	const struct option *o = opts, *p;
 	struct option *opt, *ordered = NULL, *group;
 
 	/* flatten the options that have parents */
-- 
2.39.2


