Return-Path: <linux-kernel+bounces-180674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D4E8C71A1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B611C20CC1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 06:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1606322F14;
	Thu, 16 May 2024 06:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="JOFcCl99"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AF910A23;
	Thu, 16 May 2024 06:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715840836; cv=none; b=E2o/36+j6BEjpg4SryNGL/m2VmBYQOBG56Ekm/ACHc0tGClFfM3HBS9UVMNOB5ZeG9w/YYqUF9nv51MaDuGmR4P+nV2aEj4FV88sIC2F8GuMO0ecyYvzFnlSi8WDYsINqkA7MnppxB9Thr2PKw9dQ3WOF6s+FCLflMHmn0/6q1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715840836; c=relaxed/simple;
	bh=AhiXkddz6p5J2ObTU8vOAMVtgLyhmptM7Fpfrrb0TMk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=DgLl5cVq52WztrKBpd+cP9/3IaWe/5KXI4JoWCKwyCiMpzNYE7JycQCGec6Jo39hbpKmlgYwWVeiRLt/KIeCv2AgqRFhEnBkI8U/qCiw+2e1o0Oy4uR7H4+xPCTMoi8kJY9ahMU6zVxBcWGib3opAeNRln6bBIiRpG52mIPPTg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=JOFcCl99; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715840812; x=1716445612; i=markus.elfring@web.de;
	bh=AhiXkddz6p5J2ObTU8vOAMVtgLyhmptM7Fpfrrb0TMk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JOFcCl99H0ff51oT5D0nAzsbXsnIK4c9uCO7EPsqPLPCT/ZKcxOC1y+JUfrs2BKR
	 yipgx0OfTmmVkd4NG89wiK6+ysVigUr8ocUc9IMPaJ8H1SKrDJLaweftCLsdjnf6u
	 AJ26V2bPx+QqZZZWM+YtTq2WZWUIkUOJ6ODqO77DFFR7m3qpYDT4TFL2xlMqPsU4f
	 gMixLSjczZU8BarCrQy8HaqQJ0bNQRaEPukgCc3KTY/L5ur+nHXBfHNvp40US+cFQ
	 yzvFQ+ABgf+WpnGYegee3E/1TBl6t/lIUblpc/hW5VimyESFCTmqrcd/N3byTVebV
	 ZqtF3g05cVcq+ktkLw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHEbq-1sKfr239bk-00DEk4; Thu, 16
 May 2024 08:26:52 +0200
Message-ID: <dc34d171-dc47-4817-a6f0-9f23a3afb8e7@web.de>
Date: Thu, 16 May 2024 08:26:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sui Jingfeng <sui.jingfeng@linux.dev>, dri-devel@lists.freedesktop.org,
 kernel-janitors@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Sui Jingfeng <suijingfeng@loongson.cn>
References: <20240513001243.1739336-4-sui.jingfeng@linux.dev>
Subject: Re: [PATCH 3/3] drm/loongson: Refactor lsdc device initialize and the
 output port
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240513001243.1739336-4-sui.jingfeng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Loziv5bD/koA51c/p3tvL9gE/MpR4TQk+S/VP786GZJ+8WmSCp7
 zTZth7QHAFUuzcwLIngaqOldY208Wkeo+YOoK9oCWbvNxC6tbZXLVdvdCpH28iQQVKltGSD
 vZIm535XdzKoBDaFg+wow82PQvX2tjbHvXorOHeeWour1l6i5JHFUGW1mguq4kAXeWd1Ed7
 EfgWI0VtvZmQm5uJyBp6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Gx7SC3to8nQ=;LSmx9V9mEgt0EpEx3IBuuCHPNRJ
 p5swDHeF8XIY2A12qd3gh4b5WP9qrxrGiZp2UD3wuiibHW0G9AJe8N1K6FAALOFtC4VEhISgI
 4PRRE25RWUJvx3QMJ4XlwJjxbxj21iW72sBpK0qZedRKUgOTdee18ei7bawD9hrN74QmJNs4s
 SiyPHIDWjNmiS/GoNJuUZR8DCKirP2HmMs7H3BDfdsmB5JimUsWnS5ZU6WqZvCjpMA845DUrI
 4AUWDqedw0QzQImxEvhyU04XoJoqSQvPsRKOjAzfUkP7GCunTC/KGpuceYX9Yik8bs4ycL2qx
 D+JMIMLvtkfdCToxzlViMHiDpAVTux96T6ylaAhYHTSy4R2iAe1jiJhveiu9cjfkg2GAGfLR2
 39HIVEBenqHas+BcUDL96eXicBKC1pNt9d3tbpeGClm4P86psT4Hx0rioPmkxT5QkFFZUwAhd
 SU7zaYvDWYV83hZ4C+uNtyjVFgIFbNI0pvLELd/b0u2r9FRA7FdSqLPec/albTUQwkRSjkCr8
 0ylUCi9Q+Kf+n0G2uMdmfkqxoenYVzGRfBpeoW3FD2IAEt+bE4DdQ63V91W7kaTFNuCxWDdW4
 EY9of1jpTvZDmq0x4h7dD66YAM08GGmozXwxEsoE0UkLfIdjOPf79suX7npalsa+etENHimqg
 OHOMWaaoKFDYSDGvCJET4wG9tuN41BRb6pDelpcFpLfTSZqcl/ong+sb6z12dmvAZH/guXvqj
 blBgkk3UTO/U+7UW3ReA+S+Nj1+oKVOoLnhazCnP5cSBzPt4a2HNZQ4X7g1auVaqlScNylFbO
 guTCuetUgxDG2sQC3KYvC+WPPwOmC6WcBfTZgDOvEqGWc=

=E2=80=A6
> fullfill the implement under the new framework.

fulfil the implementation?

Please improve your change descriptions another bit.

Regards,
Markus

