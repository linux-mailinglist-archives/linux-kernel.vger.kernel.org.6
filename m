Return-Path: <linux-kernel+bounces-531545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA56A441A9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C61E17AD6F3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEAF26A090;
	Tue, 25 Feb 2025 14:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BVdosQ43"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8D32641CA
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492061; cv=none; b=DlkOI04vOk1Eab1R9cf3jK8w1zjHIIydyV9sEa2kaBNhWk5+K2Hp0dIAScnzBItPdFbxNcGXWtz7TcRCs7wr0EW4MNRFYfnKaMFLX5S9k9YXY2MopaZfWPHobgIRZ3q/IDBK48WFtWNykMBt+PHACs8i0F+889Ta+e/+EkVIJ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492061; c=relaxed/simple;
	bh=fev5X7UnHuVO/6+0FZ5in0g4uDdh7qp5GkZtIQv/7GM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=mSX8jEN735+W3GsCFJfuo3HC/twsC1dHeyLtfDlCbphYcA4bOa8xWPXu9lP0jqntPqQMU96WdtuMSj08zWD15FwXNt278gtmY8gitIRBNGYVGuR2cKZv3MPEJpdR/ACW7MbhyUDv3uR5FI5TnAgt7xYsH7QAvwTbXP+Aq+czwbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BVdosQ43; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740492027; x=1741096827; i=markus.elfring@web.de;
	bh=HIc4omP8IbDtggPZZGnEqQnknZ3Pe8zMXVMDeyALcDo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BVdosQ43RXaej7khcdx8PGH40RKeuQYZa+AIXDIyBEZKnY5kbP5LekRgo2T3Apz2
	 Zyg4B+Mwb2sJgbZRNzUTm631b3TQEHkDro8AcyXpuV35aEABcXt587fUY0oYvYcCs
	 hiQGUWFFYN/m8MnsHhA3yE3ijVvNcAhcOQDAvaL2oYDDbndAGRi2Hux1t45PjuQsr
	 PuLMl0g93SQpH5GWq0BZt5Vp6nseH/G3OXsQuI7KDPZQJlsao5bwlGFGFrNNAkr3R
	 ibWxDmJUHF/noLq4FU8aafpPD+zQg65BBJc7R85ZNaj5lwoo2qcXOKhVHDiDHF0Uo
	 Ka8RCsYyUOMXTnovWw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.36]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mcpqq-1tE8td0t6o-00asfo; Tue, 25
 Feb 2025 15:00:27 +0100
Message-ID: <bc3ae5a6-9b04-4f1b-9045-2182138f748e@web.de>
Date: Tue, 25 Feb 2025 15:00:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Qianyi Liu <liuqianyi125@gmail.com>, dri-devel@lists.freedesktop.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Maxime Ripard <mripard@kernel.org>,
 Philipp Stanner <phasta@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
References: <20250221062702.1293754-1-liuqianyi125@gmail.com>
Subject: Re: [PATCH] drm/scheduler: Fix mem leak when last_scheduled signaled
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250221062702.1293754-1-liuqianyi125@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5cuqKylqTNFjYrhDL/rMPd351yTTTVW7fp9A6kzA7t79GRUkJfx
 dxhbz3J3AwlqLbO7PpR180PnYanEbE0dBHAdy3q/qLfyvA4BzvRJBU70lbJa5NQhGBVIpnO
 FJ4zpGl4dyjMIzr8ctB+HJajsRFSYPwO2grpgelfE7dPHEF0qumWBtPFARJeCw44YyJXALA
 /MGSovTRxfE26Ol94WuDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qoTXesFAs04=;LuYDJvGE4k3+uxvn5P+XMBzEvsI
 DMPnxvTcXXOPMzG3sdamynSLB/aAuhT4sGY/c8FqmCUS3LF855BcFElXlPPSvCa/mEmpR6DQ5
 WrdMyQdRW+G1jDbq++SQ73RzBUm8XOyixPVihvbxzQLHRkf+oOzOJJSehaXZmV48t34418dyX
 BJ28O+bIQ7pzGLtq07Fzm9U8Vv1loUesSoZ69fqkdbdeS8ktxcdBSBOaarGl22hQWT0SFpDvg
 Y5ZB52dC/VvlGsTvjDOoKr4z7UNVhNIil1hNfW2hEIIyE1DNxdjKsW62sGjkoHVPwaKXhOAUT
 +IkVoerzblUXsqeQUJg55s/HC/fwGe9jOkt6/TZdTtyw1DFfLH4kxN/3MBabnAXmCV9BhKK4X
 se/kZZWaLIGn7zuH9LtRreVKYzBZH2x2w5IXdAEELg39/D4p89zVivys+DOPJVg33VP4aM32L
 XXp0m8Pb15kH9I0PiydvVJYmjVFjrGVC0gQcAuoLSW6+6GKCTf9Sf6CSRcXSCYkQHhhhoFA0c
 5UKLc+uRkXeQzHGzD+lNKB2lktX9faWF4d/OzDieFn3gqwPT0XF8AETc+QnH41BuQ2ANhNeWx
 HVS9Lzt6G39I9UZ/4nocCTV2Cziex7BWRgwJfqr5RHWq5PcRBl8pk+vooYmMEzomZRXrQBZN7
 e0x7XL/UAoWlYYyXoTk6j2OzssqhG5K/fciPIyNiF2VCCSiRKnmKgSOjrvTvy0zxoEFa+ortH
 KvVoJblcvgKDi720c3M1nxPjBLM5gk3uWP/Orj2g2hkI9hm2/RBOn7pLX1lAj97EwrM5RApqw
 0H2uN5Ja9vFPqQoF4Y/VeGGXYwdZr+0QpgqsQU6HbP+/wNaO1oTYidhSsDpH6S20wEHjcNvz8
 0C3TBInTKEpCeg18IKX82h0NfcNt+PAV/F4R9p6KQdbdUKGqfcDzvGodHekbd+EWPk5d2/HjQ
 4BnUHp89fyWNjPJDFY/mS7T0isFulHH7KuU0ZyJ84Rz05lQLeAnwXmhWBX7jRi/geqw9podCE
 bPtabC9rfPfl2yxUw/80itf6Jqz6XURJ52lRN3ioXvBsIe5/Z7IHUy2bQIKCWDNty2kISi35p
 KVWA6dsFYF6Oh1QpV9PpYozUY06s/SkK5w1zMazU2sa1jTLmwUpkt06Y8w0XnFEpPeyfaY36L
 sCS861Qm/BJtDXQoxexqOdC61RpfBDJa2F/fy84abZqXCM8VhdMClzzZsFV4IZuzS2uM1tyCC
 rZERvwYKPEVYuvWYZeMHvmqthcdFZzalkrCnh2JWI+16PFkFcaBPvgYK+mJ/IGnTscHxFGNtl
 QVWSHWN+QYs1cGW6nd6UEEgHjFn55hwdavftXJuXxryKAkCz3P2ayplKzqEEzIKElniiAMPOf
 FXHi/QRTEfOlStdBM5kURFN/OUPYkW9JD0X/Ja/VoN0e6LuXQWF4KwfDOjg/ZVc4/lAT6bpaj
 OtuAgu57/ZgqI+sf7tx09wzid/is=

> Problem: If prev(last_scheduled) was already signaled I encountred a

                                               signalled? encountered?


> memory leak in drm_sched_entity_fini. This is because the
> prev(last_scheduled) fence is not free properly.

                                    freed?


> Fix: Balance the prev(last_scheduled) fence refcnt when
=E2=80=A6
                                              reference count?


Would a summary phrase like =E2=80=9CFix memory leak when last_scheduled s=
ignalled=E2=80=9D
be more appropriate?


How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.14-rc4#n145

Regards,
Markus

