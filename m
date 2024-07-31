Return-Path: <linux-kernel+bounces-268812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5812F9429AF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C34C31F2337D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782AD1A8BF8;
	Wed, 31 Jul 2024 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="ETvfGqxe";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="G5XzxLfW"
Received: from mail-edgeMUC218.fraunhofer.de (mail-edgemuc218.fraunhofer.de [192.102.154.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEFA1A6166
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.102.154.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722416056; cv=fail; b=Bt558FbQCXTyJ5VucJUNmkLFpoDBIGsGwB0WHtapdsBBW698P4bCwa6jK3QOo5xEfOKla3KMPIO4YZAHwieDcdLW4oJUEOgIBySZhX+NpON20RBtrHKcJwaVwTdAgKBUdnUsBKTKSA5dZf1FhyWGn1fnS8A9+/wwNBGdiVuviqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722416056; c=relaxed/simple;
	bh=I/12fuf7tb/VME9lxBYWpC/kJnKFDOnYLE05yqwOPPg=;
	h=From:To:CC:Subject:Date:Message-Id:Content-Type:MIME-Version; b=q9HQr4botKl6HtM58gmNUYpc2J8yVXkGVPFR7DtapEkRTVfz8krTDOKGNyWdrtvO9PBIc76vPm+Xkeoh3ovjvoV/S4mastK2rElxrEViC20hfbe8YIc68hf572WafZh4RqgvsdBFZ0A7cyL2I9QSxHgECLqD++NPLxsHVN2+laE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aisec.fraunhofer.de; spf=pass smtp.mailfrom=aisec.fraunhofer.de; dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b=ETvfGqxe; dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b=G5XzxLfW; arc=fail smtp.client-ip=192.102.154.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1722416051; x=1753952051;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=I/12fuf7tb/VME9lxBYWpC/kJnKFDOnYLE05yqwOPPg=;
  b=ETvfGqxeVDWBL6BWLtA8ui1oBeJWXRehEHOt8E0DgGScdgPbpGluOyLq
   xPPxsYuhPxxbfW2+J+7SwBihzhymwSv0x9BFMHoLt7KgyEKZY/c3EYu/P
   wcO6vvGbdFZCC5dIMwDEk8sJnCVzKkWes7sz6j7MvZEej2uxzMzmA6xP2
   4rNlrbvkcgJQj0qTvki6calBRwHchtOpSEPTpvxnSF6spJ+5vg+XpJUSL
   oRmPGkraoO02Ci/Y+eM204yN96oYtLX519fpQX0QDRnzEvzy9pUp8OHeX
   bjpZoM9saEfkvPF2x3jyBgUgmXRT8o6w6NswvnwKGqXh3gwbG0Z+oqZpT
   Q==;
X-CSE-ConnectionGUID: arGBjx9oRzmZ5Gn7SZDCcg==
X-CSE-MsgGUID: TNA4XMWMQNCGCigysU7Waw==
Authentication-Results: mail-edgeMUC218.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2EoAwAm+qlm/yYF4gpagQmBT4JEb4FxhBo8risqgSyBJ?=
 =?us-ascii?q?QNWDwEBAQEBAQEBAQgBRAQBAQMEhH+JRic0CQ4BAgEDAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QEBAQUBAQYBAQEBAQEGBwKBHYUvRg2ECoEmAQEBAQEBAQEBAQEBHQI1aBcPA?=
 =?us-ascii?q?Q0BATcBGBAMAiYCMysBDQWDAIIxAzGPdJw2gTKBAYIMAQEG2yQYgSSBIAkJA?=
 =?us-ascii?q?YEQLoNvhE4BhGiBJocWgRU1YoFib4QKToNGgmmIAow5iVAXJo8ISIEFHANZI?=
 =?us-ascii?q?RMBVRMNCgsJBYlMgy0pgW+BIoJ3glICglqBawxhh3JngQotgRGBIj1KgTyBO?=
 =?us-ascii?q?kskhUKBCoE+HUADCxgNSBEsNQYOG0MBbgemOHsTlgCzAweCNoFioTkaM5dKk?=
 =?us-ascii?q?nMBmHAipA6EOwIEAgQFAg8IgWeCFjM+gzZSGQ+OLRaDWMwndgI5AgcBCgEBA?=
 =?us-ascii?q?wmCOYY1gX8BAQ?=
IronPort-PHdr: A9a23:HLj1Yxf/ZXKb58TAKoKazsrclGM+4d/LVj580XJao6wbK/fr9sH4J
 0Wa/vVk1gKXDs3QvuhJj+PGvqynQ2EE6IaMvCNnEtRAAhEfgNgQnwsuDdTDDkv+LfXwaDc9E
 tgEX1hgrDmgZFNYHMv1e1rI+Di89zcPHBX4OwdvY+PzH4/ZlcOs0O6uvpbUZlYt5nK9NJ1oK
 xDkgQzNu5stnIFgJ60tmD7EuWBBdOkT5E86DlWVgxv6+oKM7YZuoQFxnt9kycNaSqT9efYIC
 JljSRk2OGA84sLm8CLOSweC/FIweWUbmRkbZmqN5hGvQ5Dhkw/5h/NN4wTHMfzJSJd3fxmB3
 btxQS3WjR09MAJm/l351pJ5169Yv0fywn43ydv7PbGHJN5wQY/0YN0CHG9QHctuaAZCBZy8c
 7U2MvVfB9gAiJSlokkKo1ylPRGlFaTOyBVQnX70g/AcgvUxIy3D+zckENAL4EbXqtytHqEPA
 MmO5qDm7xzgTv4GyG/syaTnfU47kfWQXux5eMD1+1sBD1j5i0W0+NC4OjGQ0t4Si2Kavs1YT
 uiElV53kjFx8hyk5dUIqtj5jNg0jWDq5H5I5NoXIPCnckFUaNHxQ9NA8iCAMI1uRdk+Bntlo
 zs+1ugesIWgL0Diqbwizh/bLvGLfIWt3zm5DbbXLy1xmXRlf7yynVC+/Bvoxu79U5ys2U1R5
 mpek9bKv2wQzRGb9MWdS/V880vgkTaC3gze8KdFdGg6j6PGLZ4mzLMq0J0VtEXIBCjtn0vqy
 qSRcy0Z
X-Talos-CUID: =?us-ascii?q?9a23=3AT8JFc2sXz9XdSd+uUcshsD3c6IssaFL3zmeBJHW?=
 =?us-ascii?q?qDFQ0Z7vKcm2806hrxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AAZXN/A1i87kWee8+/VgEL4oglDUj34KHVHAorrA?=
 =?us-ascii?q?/neKrHi1/Kiyg0wu+Xdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,251,1716242400"; 
   d="scan'208";a="2718144"
Received: from mail-mtamuc121-intra.mx.fraunhofer.de (HELO mail-mtaMUC121.fraunhofer.de) ([10.226.5.38])
  by mail-edgeMUC218.fraunhofer.de with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 31 Jul 2024 10:52:57 +0200
X-CSE-ConnectionGUID: BKgU13QAS12nxeE+Zn+Azg==
X-CSE-MsgGUID: f8pxlMb7ROWjM9SdxZqceQ==
IronPort-SDR: 66a9fb68_kP+oM+kihEGPtnYWVk8vkUWNOn2JCezxvDpUZDErjqyuwYS
 PL+PQyhFvtoVBRyEqj2YILi/g7opJjXeu7unJ/Q==
X-IPAS-Result: =?us-ascii?q?A0BcKgAm+qlm/3+zYZlaHgEBCxIMQAkcgR8LgXJSBz4qa?=
 =?us-ascii?q?YEIhBk8g00BAYUthlCCXAGcLIEsgSUDVg8BAwEBAQEBCAFEBAEBhQaJQwInN?=
 =?us-ascii?q?AkOAQIBAQIBAQEBAwIDAQEBAQEBAQEBBQEBBQEBAQIBAQYFgQ4ThXUNhmAQB?=
 =?us-ascii?q?hEPAQ0BARQjARgQDAImAjMHJAENBSKCXoIxAzECAgKPbo9RAYFAAosigTKBA?=
 =?us-ascii?q?YIMAQEGBATbHBiBJIEgCQkBgRAug2+ETgGEaIEmhxaBFTVigWJvhAqEFIJpi?=
 =?us-ascii?q?AKMOYlQFyaPCEiBBRwDWSETAVUTDQoLCQWJTIMtKYFvgSKCd4JSAoJagWsMY?=
 =?us-ascii?q?YdyZ4EKLYERgSI9SoE8gTpLJIVCgQqBPh1AAwsYDUgRLDUGDhtDAW4Hpjh7E?=
 =?us-ascii?q?5YAswMHgjaBYqE5GjOXSpJzAZhwIqQOhDsCBAIEBQIPAQEGgWc8gVkzPoM2T?=
 =?us-ascii?q?wMZD44hDBaDWMwnQzMCOQIHAQoBAQMJgjmGNYF9AQE?=
IronPort-PHdr: A9a23:+6hVexRd0VFLY0NmwlWGevWZQNpsouyeAWYlg6HP9ppQJ/3wt523J
 lfWoO5thQWUA9aT4Kdehu7fo63sHnYN5Z+RvXxRFf4EW0oLk8wLmQwnDsOfT0r9Kf/hdSshG
 8peElRi+iLzKh1OFcLzbEHVuCf34yQbBxP/MgR4PKHyHIvThN6wzOe859jYZAAb4Vj1YeZcN
 hKz/ynYqsREupZoKKs61knsr2BTcutbgEJEd3mUmQrx4Nv1wI97/nZ1mtcMsvBNS777eKJqf
 fl9N3ELI2s17cvkuFz4QA2D62E1fk4WnxFLUG2npBv6C4r2ogretdtk6BK3YMHHcrUTGhKPz
 JV3UhbatiI9DTkFr2/rpJAuhflWow309Hkdi4SBT9ylJupacJzxVM4UXTNET4VcaBNrAYSjb
 5cxNtceY9xm967g/14cqRX5HjG0DfKo6z1inmT33/Nn9bUwATPq2SsbG90MtSTmr9P8bI0UT
 LGc94PB4xfqTNJbiSal+ankXR9/u8GIQbEueMPb7Xs9ORueslCAjd25YjaX0+A3rFCR7rtHb
 fmloHAX+zhBomiLzeQ+rqmYtohP6xf02zQi8aJpB9iVV3R0TterRcgYp2SbLYxwWsQ4XyRyt
 T0nzqFToZegZ3tiIPUPwhfeb7mCb4Gt3zm6Dr/XLy1xmXRlf7yynVC+/Bvoxu79U5ys2U1R5
 mpek9bKv2wQzRGb9MWdS/V880vgkTaC3gze8KdFdGg6j6PGLZ4mzLMq0J0VtEXIBCjtn0vqy
 qSRcy0Z
IronPort-Data: A9a23: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
 2cYYRp1Cgxw9+yg3CM5Osw=
IronPort-HdrOrdr: A9a23:8eAWbKAZkd2cRj3lHem455DYdb4zR+YMi2TCHihKOHhom+ij5q
 WTdZMgpH3JYVcqKRIdcL+7VZVoLUmxyXcX2+ks1NWZMjUO0VHAROoJ0WKI+Vzd8kPFmdJg6Q
 ==
X-Talos-CUID: 9a23:N513xWMsEoVGsu5DcgpoyRdPI+keKyfb3Hr9YH2+Sk97R+jA
X-Talos-MUID: =?us-ascii?q?9a23=3ArQN8XwyOaJ1i05vALKSGqYIMgrGaqKr+EFAJtJ9?=
 =?us-ascii?q?Zge67NwkhADuNvi28T7Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,251,1716242400"; 
   d="scan'208";a="5860122"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaMUC121.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 10:52:56 +0200
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 31 Jul 2024 10:52:56 +0200
Received: from BEUP281CU002.outbound.protection.outlook.com (40.93.77.1) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11 via Frontend Transport; Wed, 31 Jul 2024 10:52:56 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFszY3j+NWeNSEEjw90APL5dgX8RMqFXaLJ6r6dekQQytZyK/BrlLPe8B5KrJGenimuB2XDIxK2Kmrnjl4JRP0rnevDn8wwU8m9xhfg28rP6GTaNQQCfyPheOMIKtMYaJITORJ648iSiiLt9C+xOCk/ba5aUyGEtVZkFAGDTP/7vMlQZuidhvYvB3Ji5vTPzXpRotFy2EHFbgQLQPTJrxS8bexbMpE8vODGOMDArPjO6S2ewpblqi5DTLssWSZfOIt0+nQ4FGeqWRoF4T3616aU5VLQN0ki0cE3W5BLTV3U/G6Uuj4pPrgr2DKIEm00Py+9riBcyBjxJIbyD7rm13w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoxILkYqXSE5dYWmO+NEKZtraZVmRRoT7fTF46a3ekw=;
 b=ahZzYDBSlA/J6Hwruz5M+RuN1YmGIKwFXD9RgDXuVySCG4H/ZLJVXMMd6TEWU0zXiTUKSMXpVj5BMnRzISSQx33Az9VUSbxa80aGfjJHVSUYS/pTWqmj4AXulpj8QtLjWeee/hUpSkrHX4kC0w0BGFkk4C+c8Pz7J0svAlqs4LIERyx+pYiGkxZ70WOpFA4Vh+DKfZSWsdr1RgiOaLYjiMjdjXQGZBL6p7kmszMMkURFIV5HyyrFqtZmogs5ogoR3SHIPfsobqpyyyE48vwGn0ef675iLj4I0+Yze8Xfd+0NaErwOp07cKCcZoi/nJC0dIHzRNXrRRLKpV00m3Tdwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoxILkYqXSE5dYWmO+NEKZtraZVmRRoT7fTF46a3ekw=;
 b=G5XzxLfWDAufp1my+eWWBkowhtVQUw6RV0Ou0mzlf/sPpay/IjBpsij65N9yxZDmOSlgjm8Zkna0Bnu9ASBaFJAKIe8y0yIDGg6rXltk6aabLZzFp3TmxL945mjmlRwPbi9OPsbCvX8QXh8LcKzLH9Xb2I/XFy3YL4JmEwRgGag=
Received: from BE1P281MB2180.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:3f::7) by
 FRYP281MB0192.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.21; Wed, 31 Jul 2024 08:52:55 +0000
Received: from BE1P281MB2180.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2e9b:1cd6:256e:55ed]) by BE1P281MB2180.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2e9b:1cd6:256e:55ed%3]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 08:52:54 +0000
From: =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo
	<acme@redhat.com>, Namhyung Kim <namhyung@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <gyroidos@aisec.fraunhofer.de>,
	=?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Subject: [PATCH] tools lib subcmd: Fixed uninitialized use of variable in parse-options
Date: Wed, 31 Jul 2024 10:52:17 +0200
Message-Id: <20240731085217.94928-1-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::9) To BE1P281MB2180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:3f::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2180:EE_|FRYP281MB0192:EE_
X-MS-Office365-Filtering-Correlation-Id: ee250ec4-997a-4ffd-1c7a-08dcb13e2afc
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWdlY0RXd0IrSHRFbTBzbHFZTThqd0pWYmRodzY4SDQwb05HT0tVOThNMDlF?=
 =?utf-8?B?bGpETkN5Q0M1YkJVT1JoRG5LN1B1MjdqUkhEVlUyTlIwN2J6cGR2b1UvRU5r?=
 =?utf-8?B?Wko2bmJaZCsrb2cwSGJPZ0JiMys3M2NnL1hkSEVpUmJURTN0MUY5dEVMMlNT?=
 =?utf-8?B?eHZEVCtYb2hIbXIrcWlBYXlLUUM5cm9OdCtSVTlTSkpsL3JiM0Z0bjZRa0hn?=
 =?utf-8?B?U2tPanFtYlQ2TE4rWitYdng2MVBnSmZXdWphQk9oSHkwc2RXQ1M2eno0a0Y0?=
 =?utf-8?B?Y3VNaC92TUtCcWNGT2JjdWE5djhGY1laekZVSU85ZHdUa0lRdTFVZ1VBL1VK?=
 =?utf-8?B?M2pMSWdoRXJUcXEzSGxRdXNqOGdabThHcFRjRFRHR1hwak5VblpxNmJTdnA5?=
 =?utf-8?B?aUVDcG1zUlBxdWtSM3FKVVoyZW1vbGs1YklhNmNFSEs0cW1MQWxwZVVyWVMx?=
 =?utf-8?B?anhrTE8wc0EydnhySXg3dkx4YUVwUitXVXdBdU52UUc4eVpWM1JWUEVBQ2xO?=
 =?utf-8?B?QUcxelJIbFY0NVQrUmxrZFhaM0VhZlNadW83VFNacFFKYUwyUHdCTy9ZUWRY?=
 =?utf-8?B?TFAwbDl6N29DQ2thTTU2cHEzY2pIMWgzTDJzTUJJa21XR3FJN0xaNms4UVJQ?=
 =?utf-8?B?T1ZoR0ZDcEt4YXpiUWFMMCs1WWpvbThjdmt4ZmFPK2dOY1UvVm94amdWSUZq?=
 =?utf-8?B?azVNWU5LbW5QTjh1VXVxeUlNRC9rblNvS3pTV2ZEZnNzVDYzUjhacUUrTXVV?=
 =?utf-8?B?bFZQK0IrRkhnMEZDOTdUN25YeHhJdWNYUFp5Mjh1cjNJOFRrZVdGTnpUcHdm?=
 =?utf-8?B?KzRUZVFUVmdEcFJqb1l5aUh1NW1pcGFKQjRZL2liQWRReDV6M0NDMmlNMGxi?=
 =?utf-8?B?enMybCtodlZGZmR5c1B4b0RZUlBidDBiQkVObXJHbU1MTXZocytyKzBEbTcv?=
 =?utf-8?B?NTgzQU8waHVObUh5UEZROUp6V24wcnQyRDkxVnNjOEV3NkpzUmFqOGgyZ0R3?=
 =?utf-8?B?Z285RURia1NKb2Q5T1lPd2FFUlM2bU1OeWowUFFlUHpkcXd4UlNWRU0yOXpE?=
 =?utf-8?B?YWlHTzlxRU95RU1QY2JUcHFKTURDR2ZpdzBUb1hScm9CdG5vOTN5elN6cjFa?=
 =?utf-8?B?N1BMUWVyQ1VMN203ZllKdnp1dTJId0JNSm5KalZNbXlOWC9zeHZXWW5KVzZh?=
 =?utf-8?B?dVNMVWsrUk1XTTJxMWVoNkczb3pxNzBDNGdmU0luMkZsZExDaTJ5cVZHd2lT?=
 =?utf-8?B?bDc2eG10WTIrOTdyWWZnN2lNUFVTVy9EaW9uSnlGOUZRN3NDYXUwM3NRTjR6?=
 =?utf-8?B?ZFdNYS8wTWQ0d3lUeW1GMlR5VmpUZ04xcXl2dmpyMm5KZmxJWHdlOEJqQ29n?=
 =?utf-8?B?b1B6Rm9IWkNyck42M2hIbmxNbEc1U3NSeXoxejdFMG5EcEZYbWRnNTdTYVp0?=
 =?utf-8?B?VE9TQ0Nid2ZKZTVwdVpXZUpQM3VxNFJWMHMwejJHcmRpTWlKRTd2dVJGL29v?=
 =?utf-8?B?WCszcDFPMzhyNzZXMkE5T2RFYit5S2VySlRzSTVNKy9FbFFkZ0pNSjRFaVZI?=
 =?utf-8?B?bGk4TnZ5OS9SMnR4Nmp4V21Ya2dKcjdWK3V6ZGtZWnRwUENiTDdiUkwwZGlh?=
 =?utf-8?B?azJ2YnJ0YmEvb0UrSkRsZlJnbDhYR2s4bnBMTmw1L0FpeWtiLysrTk9LeUVS?=
 =?utf-8?B?Um03eVBXZlRGYTBrRGFMd3lTMXphdzBMSDlxM080aWhYbXdEYWZyREVSb1gr?=
 =?utf-8?B?cExLbFBqemEwUFBpRmVXamp6Sm43MDBjK09NRllaZ0tMRzc5OVFFcE1GYmx0?=
 =?utf-8?B?azFOOGxaMjl3ek1DMU5QQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2180.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmlXb0ZDQlBTdnYyeUtNUTg5UUFZbG1oUTFHUUprbHYrcjJPTUN4MHJqL1J6?=
 =?utf-8?B?dG4yN2xQWVFqVkFYMUFOaGpaQjZiRFd5R2JOWUhYbDBJcW41QlgvTFBUT1gr?=
 =?utf-8?B?azNBbW1FMHlKYTdCMDROMTNxbkRlQXF6ci8rd0J4cjZSMnB5MUhnbmxYbzJt?=
 =?utf-8?B?OWRTNEVNZm5YWjZCQjRPejczdEd0WlIxRDhTSEFEVWRpaFB4enpqeGZtd0to?=
 =?utf-8?B?SndhcXZLWTczOWw5L3NmKzV3UThtY096bmZNZ2VqRks2aHdjRmhSN3lrWGJL?=
 =?utf-8?B?U3ZrTXRSUTZFMUhXemMxbVFuOEQ1SWE1YlBjdnNOc0FWTTJUdE1hSjhvNWRX?=
 =?utf-8?B?N1QwM1R3TjFwWitDLzJPYTF1aDRualFMRXlxTEZrakw0bFJqTlYvRHkyM1BB?=
 =?utf-8?B?RXlEVDh0dG0vc0N3UXgzaUxMVW9NbkJlK3N4WTFWbWpMSGpMMklYd0lJa09V?=
 =?utf-8?B?cnpkWlBQOGJOV2czNk1rUnlyck1INHFuMEhrdzg4RVRFRmxteloxRXFSUFlq?=
 =?utf-8?B?cGlqZTBvb1pWTFRvN29JTWxzZm5STnBQN0tqZ3RzSkUwNHVMS1hwWnZlV1BQ?=
 =?utf-8?B?KzF6UHkyVktWK2hqNzV0d2k3L29HYVJVS1p5bmtuMVllMW5zNm5sQ2Uyd00y?=
 =?utf-8?B?dWwvWmtHYUZOSmNDOW53cTZkaUh4MVRCbUVpV3lBSmdqQkg2MWJuaHNreVJY?=
 =?utf-8?B?cTJQVDVNTU5xbmQxZWhTSy9pVHVnQ2hJZHRiSzRoQklYVjN3TlZOdkVJc29E?=
 =?utf-8?B?dDRCNXB2MlEyZGZRMWE4UVhTM1l2bTg5OE9ScUZsdzZSMVNxMGZwS3JuRkQy?=
 =?utf-8?B?TVNWZ3VZRkpLRmxWREFBSzhFc0Y1dFhnNnpsbzdzaUk2RWZ4d0ZxWEhOSUFx?=
 =?utf-8?B?QW5sNmdOVEo1WkhHSHVLc0kybzcxRWF0cEZCNjkzcVBIU3BvWnduVkYzaDdS?=
 =?utf-8?B?UThIeDYyaTNsMDc2T21RYnMyMC95YjROMDFiVkt1ZFFDamhjNTUxbmxDUUlQ?=
 =?utf-8?B?dVpkRThhaHZWRzhPRGQ0SGVtZ1E0UCs1andhUVJUbFVWdHJIa3p2RTZRT01I?=
 =?utf-8?B?QlFaaUtieWlYbHlkeldyRmoySkNjZlVCMzFrMCtEREFZelhsUkEvNmt1WWk1?=
 =?utf-8?B?VVcwenZPUkxUd3ltK1h0OE5qNzJkS0hlSTBxNVNrOFZvaHplcTJiT3VPLytQ?=
 =?utf-8?B?dkVtbG9PemZKMzM4b1BKNDNuenpSYS8rYXhFcm5JM1cxSW5sZDgyS0dCRFV6?=
 =?utf-8?B?VnNTNytlSWNpRHVJNEZ6QmVRL1FYcU05L3krNjhheXgzM3FsYzkzb3BnQVJI?=
 =?utf-8?B?Mk1PNzB3Rmt2Uk84WFVHRE56ZENPUlRiaG5TUXgybTJCUW1Qakl4a1Y5SmJW?=
 =?utf-8?B?U3lRSzZWV1hETnRKKzVkbFR6SW1oM0tJdTNZS2IrWWdSU1ZpVmZweG0wekl5?=
 =?utf-8?B?NVhoSnhVWlpPRGlJRWpwWE9NSlp0NXNhVjlLa0pnYkpOUjk3bWdsMmVjd3ZT?=
 =?utf-8?B?eGNjY1RzdHpYblZZU3RNK0c2cS8vSCsvWTZDb3pxenpHWHVmUXRSODZmRTN2?=
 =?utf-8?B?Q2ZhSjB1WWFmSVhiaFFnMmFheVYwR2ZJcDBFVVc2NHE4dmhoR1dmM3czU2JL?=
 =?utf-8?B?a0I1MEc5WG9BUE9JaUo2MUl6cTNOVC8xdzNUWGF6N1BsR3VaZkgrcDVTR3U5?=
 =?utf-8?B?OXpwNjhtMFh3LzZXUzJLQWVobUpnY3ZQTzFtbGtqeHlqS20xS2JxL1ZTcC9J?=
 =?utf-8?B?Y3o2WTVPelV6b3dpamJMdnM2eGM5d2d0QUxva2U5czd1Q3VYcUp3ZzhHMUlW?=
 =?utf-8?B?STU5cUxHVW50akZ2RjJ0U0NyMzQ0ZURZQzNub1BWd2hIaDBTU2dFZkRSeVo2?=
 =?utf-8?B?VzgyUGc5WXpjMjlMMXB5NDZVYXI3Uy9TTk5FMzBVTWl5cktBUXduY1RhSDNM?=
 =?utf-8?B?RC83VS9VRUZyeUJqYUFHYWxRUmoxczhOTlluVWcrS2d1bkt0dGExa1Fid0hr?=
 =?utf-8?B?WTgzQnhxSVhDMTVrREhPRkt1UkFvYkN5MjFHYWg1YTkrd3l5d09uTWFUZ0hX?=
 =?utf-8?B?cmFnM0JXYk9pSWJFcEpYY3NZaUlsbzd6YzhFaXN1MEl4YUhRTGwxMVgrOHUv?=
 =?utf-8?B?QlhrOTc0Y2Z0U0Vkdm9xMEFnWW82aTExMWhvUEdMSkFwUlpBYVBhUVFGK3p3?=
 =?utf-8?B?YXNVNmlsd1JmZzZNYU5wZ1BpZjhRWERYQisvY05tYVRZcVcwY3JudVg2djNo?=
 =?utf-8?Q?awB19X/Edlse0vPtiDQzMJWGsO4enPPdo2MV1lu2ag=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee250ec4-997a-4ffd-1c7a-08dcb13e2afc
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2180.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 08:52:54.8434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hapS7Ivpv7mV/wp1wAbFzkPmHg84snlul9F9+qtJvAQC7zAIkXIXrGlZBWrEoTgK/hUe8YiNeuxWjQo5Gvp5BTknJqJSr9YLNXfxkyx5/1KQp4opf0AiHzZcQarQ7DtU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB0192
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


