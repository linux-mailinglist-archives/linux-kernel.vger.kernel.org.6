Return-Path: <linux-kernel+bounces-168666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 076B58BBBB4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 15:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BFF1B2170A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 13:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299782C190;
	Sat,  4 May 2024 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="aWzKdYoN"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20884A1C;
	Sat,  4 May 2024 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714827965; cv=none; b=Wt+/UHtZcP+taqqCAz+7PLxoJkn47KkFQiG5cOy4Bq+SEZNWBJJv5JSmyvHyzDzzLn2MqCx0ja39X2oxhwDWDUE7lwPX7kN+cPEMQL3s9DZEbkTev5Ui/0x+44sHg0h3Napxwy8GDI0+02tHyp4uLmb5loRaKNQcKcEYiaJBJ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714827965; c=relaxed/simple;
	bh=rm7S5XO0N8eppi9nmL2W1Piw3+dLivBrLKsKCCKFKyg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=kp5XwhF4H7+lojiLdQPQJV3Uw7VN+nt/hbL2SaN2g6j3hdhS480EgJ+5IPASQRERqGGnAWqTWWQakexBPif2ZPnyQTjuGskS0K1oP/D0VpZhCwA70tCzZlOjoc5CY0umaJlpajEqtoQadQl7fnjJRrPICDURaHCPHcYqZa6MVSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=aWzKdYoN; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714827955; x=1715432755; i=markus.elfring@web.de;
	bh=rm7S5XO0N8eppi9nmL2W1Piw3+dLivBrLKsKCCKFKyg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aWzKdYoNGt84UoCaMpAxp6uEC+Pozw5Cd8/9EcH+Qn7ykMw3jEOJ+8sP9pwDtELr
	 Ug1TIYkwew6yYLc0evu/evZ59q5HZ7PAfCXTmk9TYUirK47n3O3/X0U/G1x4XNeta
	 6xPS1OjM6b6QT1A3Js5LuCUPCNLQiJE58yPVXj8Dj37Bu7MR+N3ymaZgZobvaJAhE
	 FqamEUQLeXnZJTaLCHEImnWoc73dnoB5W4iQ/pGX3UK8JiNC87+mkfeIsdOX8lhRF
	 n4vfnz7D+LDwvYpgpknWm31lvFDAPPo02pZ5dY9q99Zvbvh1ISY3pItaXnpHzC9wc
	 swItuOdo7SBVS6EpOA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MpU1u-1sQRHL2WcO-00psPT; Sat, 04
 May 2024 15:05:55 +0200
Message-ID: <6d2dc0e6-e32a-4c47-92e5-bfb916dbeee0@web.de>
Date: Sat, 4 May 2024 15:05:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Levi Yun <ppbuk5246@gmail.com>, linux-mm@kvack.org,
 kernel-janitors@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240126152556.58791-1-ppbuk5246@gmail.com>
Subject: Re: [PATCH] kswapd: Replace try_to_freeze to
 kthread_freezable_should_stop.
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240126152556.58791-1-ppbuk5246@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7rUmHQbZFBJe+Vs3XzpJjKQH/XoTgUe3sTSmqk1ejiThXGI3AoI
 5GGO/CurzVJ1Au8Vk3F/y86KSddpAkF5Y/6EbjbHrEkOhvtWoTcyTTsMWPMcmxwU2rz1Kb8
 Ce7ZWJ6m+xhI0BD2rf0VTTWGCdtbnl14fcndePw2QCa2GrTX0epJj8DXTMDdVOeOumMXuQy
 CGDNmBOCj4jTaqhGeogmw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xxtRwIJ4vh0=;rhYShkHGJVZAI2gvklGkUC2/+NW
 ez9wpkYG3wwptBN3wlNzbfsF0dnBbly1pk5uTZk4HnnrtjIfR2tecmxi6VAqy15K9u1vgiGOE
 u/DYpSVAZxK1mRUS6eaLwBTYqMnkri70Z98Q1j5bVD12h8P6kYyKemRymo1bIkRCy0MYAK8cQ
 5djfK/rQbjpGLYAWbpCERqZM+T/vShSv8cJyjxryfCTOL06s96cpLE9HJ7t/80TUSNmrdPjpR
 l3X8gBlFYvX6qJz+RH/3YL5sFukLjS1w+CLwkXMebtcX/B9OHfwpPG2nNb7++49biRkhFB9hY
 pWgrVaIQfQu9WlMFwVxvXOnmSAH89ngOGrKsuPp3tG+s55X17Iy5B5Nd13acBfmzWSdj7E/Jm
 ZaAB0WM2XI2XgusdoXzhlEpLxjLATdZolGLkNcZuO1tCtR575dNpLqOV8GM3FynO1p54YCkmY
 kz5pI1/M1Lf/OjVSHSn3yCJTG0HT7wAZYsAhuDBhXrnIFcK86CPwQPnf/Litz3H2z5U8g3WHZ
 bXZJzcos6SYAjV2qmACqZyu34jKjwu+yhUNW65Mbnwzoj51yN5C9bmmSUnqrNKfTeRkcDhCGd
 Ki7+gh6gGnG+dlX3OOMPUKs9XImgrKt7LmXwbceudh22jglWmRTmd7GU8qgiYWK+PVJWmahvd
 3sD9Xwb4VXgS74EqIDJBoFxkUG221ux89PbVMBccT38wJjmPV/jmOLMwSHuUJqq3Ghit+4wYV
 PcQRUwphPcIyUkAn4pzcKZrw9SmGtzBT5jWYPAhHOPwvUv28duOOnmBDVlPGQqO8phCCcjXg+
 jxHLjrtBRP+JiUbLX5fjbTswJVa2kjCyzAgaVG9diLXukJVnvxrElZubv8xy4Qb3uS

Will an adjustment become relevant for the summary phrase?
Would you like to append parentheses to mentioned function names?


> Instead of using try_to_freeze, use kthread_freezable_should_stop in
> kswapd.
> By this, we can avoid unnecessary freezing when kswapd should stop.

How do you think about to add the tag =E2=80=9CFixes=E2=80=9D?

Regards,
Markus

