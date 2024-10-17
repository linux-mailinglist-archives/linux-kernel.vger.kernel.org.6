Return-Path: <linux-kernel+bounces-370419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BB69A2C21
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C524A1F221E7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A2B1E0B87;
	Thu, 17 Oct 2024 18:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Acw9OyjX"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED241DDC31;
	Thu, 17 Oct 2024 18:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729189589; cv=none; b=EZtd91ImzQG8b00KksowTSA2jgLIUCLAS1Pc4Mf3aPqp+AeWY14IEf7JuIbhEcPvoaEDeK+AM8Am5tN0TohktVOtC5Lrj4jiKzD92E+EcF7umoWcxtZQK6pZl623RWBNK3fPK/XT7MYnH8lTslPrb7E8tD4mScwgMJfO8ey3zfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729189589; c=relaxed/simple;
	bh=73LhArcldW9YWoGAUUDQD70Xc6UvchdZ6iaCXM4EhDw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=jyW8+D65RwHqnh+8g6hxgONCbyq1Tq9LsPn7wsuiq7mQB6qBxQuSru1lVpDuZwCeJP0AbfP6gemDCz/Y4ky6DeD1XJnBQDo3R7lW2Viv6mK5j92gSje70paWDC7wPqAcNYHKHhjdIMq06+DtnKKlNjxLFtoWpLyIQWdnZ+0GUdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Acw9OyjX; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729189584; x=1729794384; i=markus.elfring@web.de;
	bh=73LhArcldW9YWoGAUUDQD70Xc6UvchdZ6iaCXM4EhDw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Acw9OyjXs7wAmlpf7VNBmGHcv6iA4K5tdMUMd+KTlEtOk/1/nGtHTQGBxm6PqwyY
	 k92/DomDJkbcS8nNgDuibD3wh/8Cv3ASyCFTYRouH/l5IPc9D5HcWxRnifMVgWWYI
	 Ja6dz+31TvUmGjf7Q9DS5IO0KonSstj0O4OwlF21EBOkLv003kKAfZMGq/ZP1xcub
	 6STWjF5xrwDmkz6Jsj+bi+T7+wq/3a89jEiaV36JnKoWcjqzKbShyGvxTYjRzKlUc
	 UU26gqp6n536/6hoHx4P5H/JmlIfcwLOUGM0G6V7An3pzEvvHIseMu3hU48BkZeha
	 UVWbmhqIQ9HJnw6y3g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Ml46y-1tmyTI2g8a-00lUMp; Thu, 17
 Oct 2024 20:20:36 +0200
Message-ID: <e8bf7b33-01da-43fb-b71e-cd86a02be2e6@web.de>
Date: Thu, 17 Oct 2024 20:20:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: kernel-janitors@vger.kernel.org, cocci@inria.fr,
 Peter Zijlstra <peterz@infradead.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: =?UTF-8?Q?=5BRFC=5D_Growing_usage_of_the_attribute_=E2=80=9C=5F=5Ff?=
 =?UTF-8?B?cmVl4oCdPw==?=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:fOqmabauarM4Mm0Kro7lXPvx52ESGm/sJk6b1D08p6JdQW/nbQv
 UVgShpEpzfIYu/mwL9TtDcPXwyr0eE3HOG9odyw+wdkeca+biwkLt1xZwqIEWcIOpz+C3ls
 Bd2dnBF/Q5KwQOzYbKwgMK3LefW3AFmVzTrJ5wyjAq/bJc4VyLhz/3zBscOUNUgnMjpOeHg
 FNAyA8c87vZVpeiDxVDiw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FaRCpcyoAOM=;Hogbr8WehlRKd2Tt28sGNg1TOPN
 z3I0tejqAhGQ0fMHh/WoQqRAxLHh+j9ICftflvaGSMftdIYbW83ZbW9qQi1jeYzfEt95jUBee
 fvS10OpVhies0Yzuia6qoGiOi4l7cXhfOKL1Y5gIq9cgEePXh1GxeySvEdsm+fGXZGnqnX84D
 tlMUa0esT0dt1o4TZSgRKG/iIggjcePrQlgscH1hlMNG0X2zmVuwCcpBDVePn1jWJCOTsUdA2
 KfjLpQ6tPXyVMBSC3nbYJc1g5+kZ7yXPwgO+BdwUI3FCPEFe+8pZ3VZCZnJ5uHmaWB0uua0Sv
 thjMb9jbfXVpDbkTyZwyKI7akeh96sIvJAojahvq+9B5e0tQ32NCasVSDBULIGJzxZJ4qJnIe
 qL8/2Qv909gU0AomvEhoBEgwZEdVkme4mjTLt+VZusFJzJZsq/kAqNpbkQ4s3Yf1oZcN8sS2N
 FGDEQO5Bq04aVrL9DPnOYwCje+JyzvQi990vVSOeaDJXOkqdv6Ga1/7Rl3elaOCQ19pamQ1wN
 GvFs8KN4ch98dJAShcg1fx0N8kBsJgqXjWQYALFWVvXkwaRHSKKtPrwB/podvAqIOhwvNwie+
 yqErxLrU/uwX7E0KNl4b3ieKhQ9GxjYh8u7jIN1w10Cp4J0yAcvkjGQNj1LqUwpqTKwfIQ4Iz
 uEgQ6Yo6xztxcciir2EeMiFicPv3uTO1LZJCTsq1iXwGyccHM413IuWCJx0grQtBaWgG9bxQE
 AqcHlMKWN8Pe8Xi+gB5yhuvY0KwbjTrle4f3MtgCEs/zD/jr2KDElfOtPOZ04kCLXp+bKjOz+
 Wj2oZBs71tN47QhJTM+6WAPA==

SGVsbG8sDQoNClRoZSB1c2FnZSBvZiB0aGUgYXR0cmlidXRlIOKAnF9fZnJlZeKAnSBpcyBldm9s
dmluZyBzaW5jZSBpdCBiZWNhbWUgc3VwcG9ydGVkDQpmb3Igc29tZSBwcm9ncmFtbWluZyBpbnRl
cmZhY2VzIGJ5IGNvbnRyaWJ1dGlvbnMgb2YgUGV0ZXIgWmlqbHN0cmENCm9uIDIwMjMtMDUtMjYu
DQpTZWUgYWxzbyB0aGUgY29tbWl0IDU0ZGE2YTA5MjQzMTFjN2NmNTAxNTUzMzk5MWU0NGZiOGVi
MTI3NzMgKCJsb2NraW5nOg0KSW50cm9kdWNlIF9fY2xlYW51cCgpIGJhc2VkIGluZnJhc3RydWN0
dXJlIikuDQoNCkkgd291bGQgbGlrZSB0byBwcmVzZW50IGEgY29ycmVzcG9uZGluZyByZXN1bHQg
d2hpY2ggY2FuIGJlIGRldGVybWluZWQNCmFsc28gYnkgdGhlIG1lYW5zIG9mIHRoZSBzZW1hbnRp
YyBwYXRjaCBsYW5ndWFnZSAoQ29jY2luZWxsZSkNCmJhc2VkIG9uIHNvdXJjZSBjb2RlIG9mIHRo
ZSBzb2Z0d2FyZSDigJxMaW51eCBuZXh0LTIwMjQxMDE34oCdLg0KDQrilZTilZDilZDilZDilZDi
lZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDi
laTilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZcNCuKVkSAgICAgIHZhcmlhbnQg
ICAgICAgICAg4pSCIGluY2lkZW5jZSDilZENCuKVoOKVkOKVkOKVkOKVkOKVkOKVkOKVkOKVkOKV
kOKVkOKVkOKVkOKVkOKVkOKVkOKVkOKVkOKVkOKVkOKVkOKVkOKVkOKVkOKVquKVkOKVkOKVkOKV
kOKVkOKVkOKVkOKVkOKVkOKVkOKVkOKVow0K4pWRIGtmcmVlICAgICAgICAgICAgICAgICDilIIg
ICAgMjQzICAgIOKVkQ0K4pWRIGRldmljZV9ub2RlICAgICAgICAgICDilIIgICAgOTQgICAgIOKV
kQ0K4pWRIGZ3bm9kZV9oYW5kbGUgICAgICAgICDilIIgICAgOSAgICAgIOKVkQ0K4pWRIHFjb21f
dHptZW0gICAgICAgICAgICDilIIgICAgOSAgICAgIOKVkQ0K4pWRIGdwaW9fZGV2aWNlX3B1dCAg
ICAgICDilIIgICAgNyAgICAgIOKVkQ0K4pWRIGt2ZnJlZSAgICAgICAgICAgICAgICDilIIgICAg
NyAgICAgIOKVkQ0K4pWRIGJpdG1hcCAgICAgICAgICAgICAgICDilIIgICAgNiAgICAgIOKVkQ0K
4pWRIHB1dF9kZXZpY2UgICAgICAgICAgICDilIIgICAgNiAgICAgIOKVkQ0K4pWRIHB1dF9jeGxf
cm9vdCAgICAgICAgICDilIIgICAgNSAgICAgIOKVkQ0K4pWRIGZyZWVfcGVyZl94YSAgICAgICAg
ICDilIIgICAgNCAgICAgIOKVkQ0K4pWRIHBjaV9kZXZfcHV0ICAgICAgICAgICDilIIgICAgMyAg
ICAgIOKVkQ0K4pWRIHB1dF9jeGxfcG9ydCAgICAgICAgICDilIIgICAgMyAgICAgIOKVkQ0K4pWR
IGtmcmVlX3NlbnNpdGl2ZSAgICAgICDilIIgICAgMiAgICAgIOKVkQ0K4pWRIHNuZF9jYXJkX3Vu
cmVmICAgICAgICDilIIgICAgMiAgICAgIOKVkQ0K4pWRIHg1MDlfZnJlZV9jZXJ0aWZpY2F0ZSDi
lIIgICAgMiAgICAgIOKVkQ0K4pWRIGNsZWFudXBfZGF4ICAgICAgICAgICDilIIgICAgMSAgICAg
IOKVkQ0K4pWRIGRlbF9jeGxfcmVzb3VyY2UgICAgICDilIIgICAgMSAgICAgIOKVkQ0K4pWRIGRz
bWFzICAgICAgICAgICAgICAgICDilIIgICAgMSAgICAgIOKVkQ0K4pWRIGZpcm13YXJlICAgICAg
ICAgICAgICDilIIgICAgMSAgICAgIOKVkQ0K4pWRIGZwdXQgICAgICAgICAgICAgICAgICDilIIg
ICAgMSAgICAgIOKVkQ0K4pWRIGZyZWVfY21kX21lbSAgICAgICAgICDilIIgICAgMSAgICAgIOKV
kQ0K4pWRIGZyZWVfY21kcyAgICAgICAgICAgICDilIIgICAgMSAgICAgIOKVkQ0K4pWRIHBzdG9y
ZV9pcHV0ICAgICAgICAgICDilIIgICAgMSAgICAgIOKVkQ0K4pWRIHBzdG9yZV9wcml2YXRlICAg
ICAgICDilIIgICAgMSAgICAgIOKVkQ0K4pWRIHB1dF9jeGxyZCAgICAgICAgICAgICDilIIgICAg
MSAgICAgIOKVkQ0K4pWa4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ
4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWn4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ
4pWQ4pWQ4pWdDQoNCg0KSG93IHdpbGwgZGV2ZWxvcG1lbnQgaW50ZXJlc3RzIGV2b2x2ZSBmdXJ0
aGVyPw0KDQpSZWdhcmRzLA0KTWFya3VzDQo=

