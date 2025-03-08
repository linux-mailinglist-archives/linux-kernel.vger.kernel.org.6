Return-Path: <linux-kernel+bounces-552524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E57A57AC1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 14:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F6AD167AD4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 13:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8892A1B87CB;
	Sat,  8 Mar 2025 13:48:49 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438341B0F18
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741441729; cv=none; b=Nr0QBadnd3oeGo26co9usqhZPdPVQlEWgi09qZYJpQYxeeCSP0g+cefXl/ueLdJ7gPzcEMk/15haqIOGrTLOeR59+iRvCP9tBSGC+m/9v+jpi4TdMPLkcWRRpXkWSJyy8fso6iIR5CYyEK8BVPZuz65FCnm1RiRN2bkSl6/Y2Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741441729; c=relaxed/simple;
	bh=x8L8uli7Myj08OMRg4LrX6zscoXseo+X57M/4nZHWsg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=haddfUn2bbKF8spbV5L2j1b7/Cqv3CI/zd1zN98Dyvd4aOVfzksj+hCrF1t6jnipYizlKP19i7mPEXprgNSTmgMRQ3e6Dut4IEjIsBD6xT7JgFv1ZKquJiGOKMfEq7aurn362hXh0g3E45/iqM1Si/cRTw2ZZ+d+0zkLuike2TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Tejun Heo <tj@kernel.org>
CC: "void@manifault.com" <void@manifault.com>, "arighi@nvidia.com"
	<arighi@nvidia.com>, "changwoo@igalia.com" <changwoo@igalia.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "bsegall@google.com" <bsegall@google.com>,
	"mgorman@suse.de" <mgorman@suse.de>, "vschneid@redhat.com"
	<vschneid@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogWz8/Pz9dIFJlOiBbUEFUQ0hdIHNjaGVkX2V4dDogU2ltcGxpZnkg?=
 =?gb2312?Q?cpumask_computation_in_balance=5Fscx?=
Thread-Topic: [????] Re: [PATCH] sched_ext: Simplify cpumask computation in
 balance_scx
Thread-Index: AQHbjyyKE7Ts+jm/YkeB7je4YAozwrNnTymAgAEZK1A=
Date: Sat, 8 Mar 2025 13:32:07 +0000
Message-ID: <7f05b88f883848a583e36afe97bb0c7c@baidu.com>
References: <20250307064533.2663-1-lirongqing@baidu.com>
 <Z8sXt5eRyga_ukql@slm.duckdns.org>
In-Reply-To: <Z8sXt5eRyga_ukql@slm.duckdns.org>
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
X-FEAS-Client-IP: 10.127.64.36
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 52:10:53:SYSTEM

PiBIb3cgaXMgY3B1bWFza19vZigpIGV4cGVuc2l2ZT8gSSBoYXZlIGEgaGFyZCB0aW1lIHNlZWlu
ZyBob3cgdGhpcyB3b3VsZA0KPiBhY3R1YWxseSBpbXByb3ZlIGFueXRoaW5nLiBEbyB5b3UgaGF2
ZSBhbnkgbWVhc3VyZW1lbnRzPw0KPiANCg0KZm9yX2VhY2hfY3B1X2FuZG5vdCtjcHVtYXNrX29m
IGlzIG1vcmUgZmFzdGVyDQpzb3JyeSBmb3IgdGhpcyBub2lzZQ0KDQp0aGFua3MNCg==

