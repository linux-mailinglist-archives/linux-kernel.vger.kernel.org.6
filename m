Return-Path: <linux-kernel+bounces-254777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B8B93377A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742E92814D8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020D8182AE;
	Wed, 17 Jul 2024 06:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="UabpUZVX"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5371B948;
	Wed, 17 Jul 2024 06:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721199544; cv=none; b=pwCwGYMoJ8Ds2ArGPeDetzxeh+3GGTsGlIrZVh50xNddPrlO1vfDxFn4yPJN2K2OZr8DqTJtMMZetYPPtofpVQNnEAYlG7u44OBVixGLi7YNDR0cqNKtOc2nZ6wIpZngugbvEWzP0Eroc/yqRGrQDWUubBdEXMj2BKB1LUF99xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721199544; c=relaxed/simple;
	bh=pbbU9/TzxhEHItO5TAmPaoXqw/Q2R3mIiFX1cmaykEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dl4OYZs1ygUAJodWUxCfLU0GUFFvwdttJWYzfyK9CR3WQyqCG6wQ+vAu0EXwgwck2kPCeUwocukARQqtnV2k+PMxSrHLLlz3fuEfdMsZKIyhJhBZaT0lGpfBrHfSePk3MS/hDUlwIClJ1gOl8Ql2oYbX0yIpt6bcnHmOqa01Cxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=UabpUZVX; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721199501; x=1721804301; i=markus.elfring@web.de;
	bh=pbbU9/TzxhEHItO5TAmPaoXqw/Q2R3mIiFX1cmaykEM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UabpUZVX/prXXrIiHEbzB0UtbTyph6MDCs0v7G2XE2CAQF3sWGk09fHedu9fHrZB
	 qVUuvE/Kzqmj+fpTP/6ma94FIuruJDvyME9/Be1AoCVo/yDHWs137s7xACGhkbE3q
	 v3L5wguDSo0yzUwiR2emknZg445C8svf0qXtGRfM81nlAWpIzPnMJr+V4xawO55fS
	 BF3aiPhI0zZY4g0SD+Xpm+iMGTbM0JQIQDtIOWaqKitrZf3ETs9glrdEcjzfoCxrq
	 u0evtUeIlz0zjsZpVzH8DDXx2tK1TpFEHKYZ5Mi4F9J0rN2s1drBfHyjqfdsIkoNS
	 +a60lsORX+OrEWTmOA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Md6xz-1ru5V82M55-00o5xu; Wed, 17
 Jul 2024 08:58:21 +0200
Message-ID: <2cc9a090-7d30-49c5-a4c1-1cc1271bf641@web.de>
Date: Wed, 17 Jul 2024 08:58:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: x86/resctrl: Use seq_putc() in two functions
To: Christian Heusel <christian@heusel.eu>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
References: <d4be0dc8-f6db-4bf1-bb6d-ccff161dfde9@web.de>
 <cb908d7f-db6a-4b04-8867-bf36fb2dd45f@intel.com>
 <bceb7649-f2fe-4418-99c3-e054f0b0e778@heusel.eu>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <bceb7649-f2fe-4418-99c3-e054f0b0e778@heusel.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:PVNkBJqpxaSQv/BbYzjO1YWx+MHiMLPEsfJ5TL3s70WN5PpV1Yx
 2yP1TREuX7s+684aenYSlyX8I4d+tH8s4aHUGB/jK0x/pk4Q12EAVT+g1PoFl1gZZq/0mR2
 NHm1gR2uuxfXQga7S0oREte78G1K+yX/lUfMvi7O/tLp8uzKjJVSeggoLJ4kkNFa139rZ3g
 olEHGEn8WOXI/fgHnXB/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qS2T9jhw8qU=;qJctjSrmlPBVYvU+lrj/5FTyRoo
 pSxiVUCQ01OL4NCSxLE6GmKjLv4SmYOabrbdlEYuJi4uvLpFj2iIizv7Q8GAHCUYUgzs8fDAC
 mzDOPS2d3CGlqlVldaHo7LVYTyK+6AXT1eeJfDpK4MGaA/1S6hF155sIzC8r4AZ09UCKBxMGw
 zqaDNxQxcTslDmAD8y7qgWdQDhucZDafhD9ZbVPKjExoGCeNSlSBRdW0iPiZuQ3P76ct+W6t+
 shzNh7HvY1UrJivIBz7A4CC8B1Eo+mXWv6WCFb3kA7NdrbpTUfbuxX5gL6F4NsnIHwPWoTONv
 fm99U6Lw19p/GVjmQ9yv+zdJ7YWPN3acWjal5MQDFElmRiL/2iM5u4YW17gPLxAb7yF9QmYgd
 hMNPvJK5QEJwRvSmwDEK5qtXcBPAAjsYmfttP7dzroqYFnAk24i1YQNgMbEXhlxjcZ2LSx7xr
 13bppbI2H6oL8Ga9ZWOgdqxWxSHHCJQn9MwkhATgmk+j4W7vtkx2uY4/K4rzUXkfhnZiQHU6N
 SFKVeWWPZJkW7WN7lmdtvZmNGRmNgb3TDi3Il75/LOaUjz4//hPjwCg/yHPbl02rSensiFPfb
 rApHdn/N20FRlh0CZuEyM8+7ZN0iyk3xC+yy15yehhVNifksAWiJs0vP98v1rUcBznOqdCt3E
 HrRgTUqxP6iyyRuY2E8jUjAuw6gooMqT3/ouj1m1s7pRpfkNeCcJ1w6/8Nw3dhbs3kDEz27hG
 dOIqws9fJnXhenAFc+Hm/uuHOKkaJBWqpxhDAv+cILNSs9ewqZXBHSU5rD4GvlZvp0a0DzYLx
 9XvcC4FQI8XDN378RPSlxiTw==

> Just to give some context to this: Markus usually uses extra
> (out-of-tree) coccinelle scripts to change code to his liking,

I occasionally dare to present special change possibilities.


> sometimes these are good changes,

These can be nice.


> sometimes they are meaningless.

Further development ideas can trigger corresponding communication challenges.

Regards,
Markus

