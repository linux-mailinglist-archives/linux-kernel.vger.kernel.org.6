Return-Path: <linux-kernel+bounces-516076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D8FA36CB7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 10:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BF313AC189
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 09:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5FE19ABC6;
	Sat, 15 Feb 2025 09:03:03 +0000 (UTC)
Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BE423A9
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739610183; cv=none; b=piMx+Ymh+lMMTsg4NIw1s9qnbrKerrWKKa/Yby8xygyZU0vCQlZbd8U0jp/6KFuN/BdjZ248fjBD9Fz6P0XtNGKdsEO2XOxOrzcYNrLJOJrNI5ZFymGZaP4aHhD897dqi0eJE7nM1kv6u5/7GjEAL4P0R81nkI5E7Doo4KYLNtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739610183; c=relaxed/simple;
	bh=dtRZDjmpwlFZAR2qVzFYL4AJK9HPmwLNipkX1RGYTgg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dO9vd/lWHMuaaAi3+wixld57VHQ+0G1WwdcHrUIdsM5jqzSPHR5inScXIbt8Udo6H/U9rYdtLC80jvFRifSMMEvfiq+Zc5UTwWgdZC5VuaDh04oY91XwTj84RVDp0NCsGRlMJ3dstMSwPsIqZnn9SnPEScvqM7WV5PPvpZFPkoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w011.hihonor.com (unknown [10.68.20.122])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4Yw2ww5BN7zYkxhG;
	Sat, 15 Feb 2025 17:02:08 +0800 (CST)
Received: from a004.hihonor.com (10.68.27.131) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 15 Feb
 2025 17:02:58 +0800
Received: from a007.hihonor.com (10.68.22.31) by a004.hihonor.com
 (10.68.27.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 15 Feb
 2025 17:02:58 +0800
Received: from a007.hihonor.com ([fe80::e866:83ac:f23b:c25c]) by
 a007.hihonor.com ([fe80::e866:83ac:f23b:c25c%10]) with mapi id
 15.02.1544.011; Sat, 15 Feb 2025 17:02:58 +0800
From: gaoxu <gaoxu2@honor.com>
To: Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, Barry Song <21cnbao@gmail.com>, "Yosry
 Ahmed" <yosry.ahmed@linux.dev>, yipengxiang <yipengxiang@honor.com>
Subject: =?gb2312?B?s7e72DogW1BBVENIIHYzXSBtbTogRml4IHBvc3NpYmxlIE5VTEwgcG9pbnRl?=
 =?gb2312?B?ciBkZXJlZmVyZW5jZSBpbiBfX3N3YXBfZHVwbGljYXRl?=
Thread-Topic: [PATCH v3] mm: Fix possible NULL pointer dereference in
 __swap_duplicate
Thread-Index: AQHbf4hopAzXvKzOR6qFXWGTfwGJZg==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Sat, 15 Feb 2025 09:02:58 +0000
Message-ID: <21fcd086831f47078c2fb2175048b33c@honor.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Z2FveHUgvauzt7vY08q8/qGwW1BBVENIIHYzXSBtbTogRml4IHBvc3NpYmxlIE5VTEwgcG9pbnRl
ciBkZXJlZmVyZW5jZSBpbiBfX3N3YXBfZHVwbGljYXRlobGhow==

