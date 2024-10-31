Return-Path: <linux-kernel+bounces-391072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D129B824F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62D2D1F23333
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2976C1C1AC9;
	Thu, 31 Oct 2024 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="hBDmvD4i"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B7F13DDB9
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 18:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730398205; cv=none; b=YimnpvE2U8xHO+nawXVnKKeU0BDuzPmfjPPf3Abdvr2VabBOrFQydERg9UdmaECOZpBGvXF1x4PKjXCRmmP7jrl4Dzv++liYd2G8DgL9B/U9DLYR+3gebi2QjB8YJr2p3iifOxi5YanN78JuDDrNTnQEQWOsjbu4kzgjirFFuGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730398205; c=relaxed/simple;
	bh=hbTUrlcOE5nRR9NElb/9zmfhU1oUp6dXMa+Aes8gI5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VNxnbI5I7PFHdEWZ5bE7hPv5PgnJTOoDCqXN2DUbRbSE1qRNKc71rTAqeoB4Vttz9xmdiY74k/i/LKxv4Fo2xNh67tHGjivLQOmKnwMVrR2xtNNLF2U8Mr080Bk7Cxb8GakZZs1G9Mh3orxeUNslM6elOtuUKFs/m8NVwGgRM6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=hBDmvD4i; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730398159; x=1731002959; i=markus.elfring@web.de;
	bh=hbTUrlcOE5nRR9NElb/9zmfhU1oUp6dXMa+Aes8gI5w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hBDmvD4iv54XWGawiHaCfmRLOaYdO6Yfon8wjXTduLpqspXGmFjtrqUTrDSYKO3h
	 pZjtX5iVnBm/1VcdyaLQy7+dOgjUMPPVmpZtIwnNQwF+5xVG3Eq/ikLV/c89iAMjv
	 82c0fzghigJFxjsAmdJ/LxyBrpcLXijI1TErJXj4tI6JQX2AWZHA9o2R99lQHeQ1c
	 dHv2VTzVhmdojNjdlhsR+U1QnkjdEX3TCZ6iTN9zinZeA/h+JdV/zQTuHwZMiorFx
	 GBlRwPkNKJ6FD52dNVz+KE38mU5uzmqa/aJggB3Qo51FN0Rt9MCtrE98AgYPaeZHs
	 xpFzS0ffpB/qlTwwTQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MeDMR-1tfttI1pqh-00oysz; Thu, 31
 Oct 2024 19:09:19 +0100
Message-ID: <9d381d9a-3d4e-455e-a1e0-ac737f8d7852@web.de>
Date: Thu, 31 Oct 2024 19:09:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: phy: ocelot-serdes: Fix IS_ERR vs NULL bug in serdes_probe()
To: Colin Foster <colin.foster@in-advantage.com>,
 Jinjie Ruan <ruanjinjie@huawei.com>, linux-phy@lists.infradead.org,
 "David S. Miller" <davem@davemloft.net>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Thierry Reding
 <treding@nvidia.com>, Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <ZyOUr7iDa9nFBxgq@colin-ia-desktop>
 <28bef742-84ca-4d52-8d19-258f1a3d695b@web.de>
 <ZyPCgOByeVNZC5rt@colin-ia-desktop>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZyPCgOByeVNZC5rt@colin-ia-desktop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+LG3F+RQYC31y0sVjd1hbg5gYPRvEU+8+SbwOqPe4CV6Is0MbBo
 MAzl+hiGQUUtBcqPBD5RC7yjGbSwbWyS4hf4mwiuZDdR4MQXsUUVwngz2Z8LhDV5pcbf1YX
 x+iFbUQZa/+BZypRJoh3GV9ALtq3IwIIa6WPTs8TcaaXmyWfQsi8UGt1C4BlgctKVKuseLk
 oltyh8T4/4H6tP5yu94QA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ta5smnulrjM=;5oSH9lof834HbK0DxHCC72BC4gx
 u5CoTN0D4fNYxK4WLuTsQk/oH1Lg5LB1Ly+t2tNnMLqV4JcbbQzqBrch63g9tA61bbRcG3kml
 bZ62wpGk/PL3SuvIBvIOQrMNvlEhP1GL6CCJ/yJJbEh2m5ylsQH9KJ28Kn5HzvlfTZoZ4wWK8
 sjmbfhQa6ih3zVhHVVrD9MJTvqRtuK28kB3FkJU3heKdTIY2gsi9vefA+3uO/XqXT++VaiMmd
 SaIK+KOhsgO08zMBsbDk/nALPf4T8ZxcBV9b4AkvAja5nxuAMNGw9ySILhfQ0kDEsl19luRYx
 CYDutT0vG8b77n5sBeFQ+xxSdQBrRFZoG1xEEQj1U7z3gIxBzDPjtx55rnZgboO/s+dPb+lkb
 QRB3oDRwC+FOTY7IanyaNXS7VBXqUhTB3txSA0t6IdQghWI9q2ps1/6fNjHXXDuPtqGl5t+Wt
 4/3IDa437tb/dH/ElvlXml1Qe1h5Bma6NsVLBZkp/x4P2O5gQdbT8MYJTVkz7SXdHWtwDsrsv
 /Js6IcXE4Y2dFeIAlHoNZJZMZHiiomYXGnWmy+jadnln5kp7TL/+Wc2+l0HI6ttu8ngLTW4F7
 NBiAj3SwgbOLZ+VMSJYSrmUFcOpugwYfGP2Zq09+JdHkVYFituWbxFeRerWgdv4jokSmYv01T
 19UBLW7+Lvbd+xBxbutJg6fdBavN+RH6HVmfvkG4ynJhd2hEhLB3LnkF0p3W7v3loXMb+4yjP
 R3C6g33g73IzEzjQkvJ0st5/WOruvwKb4cgQm5vq+kAMzlEhgvkHLkt6tv5lE1AZpnlTlwvFZ
 iG9FnBSkYAJhWs4ghvAZmI+g==

> You're absolutely right. Apologies.
>
> Acked-by: Colin Foster <colin.foster@in-advantage.com>
> Revieved-by: Colin Foster <colin.foster@in-advantage.com>
Please choose one of these tags (without a typo).

Regards,
Markus

