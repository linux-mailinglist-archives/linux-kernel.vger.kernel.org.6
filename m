Return-Path: <linux-kernel+bounces-279226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6A094BAB8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BD39B20C5D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EA3189F4B;
	Thu,  8 Aug 2024 10:19:32 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B7B146A7B
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723112372; cv=none; b=bO2YSJTF0zLMLhxvYseTIVhSkcv0WqSxCiF9k7gmtQfV07KZtYe27yd7BzUl0JQDihfriUj9JKh+BijJgu+Qz/gRJXUgHffGmDj6aaGztS4uEXx2T9koCUtBytwMvK/r+x/76iAinyoTswCMAUo4/8VELIHq/dzZ3kASz0kjybg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723112372; c=relaxed/simple;
	bh=WLnUFoeF643vW8fEJrcV0VORngmcOZAU+qzooeDLFaU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=o11tMiLBG+77yYxWGg2DPmZr/gqOumKsmcRMAGMbsgmIjcXnfJxKqBvgpWuXhIO+qppuZ4IYw1J0CjYSUzOe7RHRrV+79XcshbOuE2KeozQd6N5wyii5bNLKbV0QbUuL5Z2STKkMEg6K83CWm2qQ4cuYVleQshsgOXCBm+5NS5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 478AIqu0060193;
	Thu, 8 Aug 2024 18:18:53 +0800 (GMT-8)
	(envelope-from zhang.chunA@h3c.com)
Received: from DAG6EX10-BJD.srv.huawei-3com.com (unknown [10.153.34.12])
	by mail.maildlp.com (Postfix) with ESMTP id 7F6B3200472B;
	Thu,  8 Aug 2024 18:23:49 +0800 (CST)
Received: from DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11) by
 DAG6EX10-BJD.srv.huawei-3com.com (10.153.34.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Thu, 8 Aug 2024 18:18:55 +0800
Received: from DAG6EX09-BJD.srv.huawei-3com.com ([fe80::bdc5:ad7:2347:12a5])
 by DAG6EX09-BJD.srv.huawei-3com.com ([fe80::bdc5:ad7:2347:12a5%4]) with mapi
 id 15.02.1258.027; Thu, 8 Aug 2024 18:18:55 +0800
From: Zhangchun <zhang.chunA@h3c.com>
To: Zhangchun <zhang.chunA@h3c.com>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Jiaoxupo
	<jiaoxupo@h3c.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "shaohaojize@126.com" <shaohaojize@126.com>,
        Zhangzhansheng
	<zhang.zhansheng@h3c.com>,
        Zhangzhengming <zhang.zhengming@h3c.com>
Subject: =?gb2312?B?s7e72DogW1BBVENIIHYzXSBtbTogR2l2ZSBrbWFwX2xvY2sgYmVmb3JlIGNh?=
 =?gb2312?B?bGwgZmx1c2hfdGxiX2tlcm5lbF9yYW5no6xhdm9pZCBrbWFwX2hpZ2ggZGVh?=
 =?gb2312?Q?dlock.?=
Thread-Topic: =?gb2312?B?W1BBVENIIHYzXSBtbTogR2l2ZSBrbWFwX2xvY2sgYmVmb3JlIGNhbGwgZmx1?=
 =?gb2312?B?c2hfdGxiX2tlcm5lbF9yYW5no6xhdm9pZCBrbWFwX2hpZ2ggZGVhZGxvY2su?=
Thread-Index: AQHa6Xxf7Of4OUxtBUqtdqBXtqVF9A==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 33
X-FaxNumberOfPages: 0
Date: Thu, 8 Aug 2024 10:18:55 +0000
Message-ID: <5f8e461a56784672909a968a3cc8f83b@h3c.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-sender-location: DAG2
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 478AIqu0060193

emhhbmdjaHVuICiy2df3z7XNs7+qt6Kyvy9OaW5nT1MsIFJEKSC9q7O3u9jTyrz+obBbUEFUQ0gg
djNdIG1tOiBHaXZlIGttYXBfbG9jayBiZWZvcmUgY2FsbCBmbHVzaF90bGJfa2VybmVsX3Jhbmej
rGF2b2lkIGttYXBfaGlnaCBkZWFkbG9jay6hsaGj

