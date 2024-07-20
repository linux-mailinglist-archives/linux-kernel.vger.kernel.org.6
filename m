Return-Path: <linux-kernel+bounces-257889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D461C938026
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 11:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8624D1F21D01
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 09:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DD447F7F;
	Sat, 20 Jul 2024 09:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="rITZwrpM"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC6B2C861
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721466922; cv=none; b=O5vV5vc9oMXtaStJV/BsAkg+kANH9hA5FMtWrnweqKZNnpebX/UDgqV/PRSRzSK628yJKKrJvVU0ZQr525T4BddWLYocrycTiQclU5IPWRbPCzqolNIVq93bBaUr4MV9nVfYYG/rf3e5Hf90uMu8zHafBh0SgwCqHlAAwCIiyJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721466922; c=relaxed/simple;
	bh=wpGdRSLufUGo2IMjAqtxjfUJU3CQ/ZGSTikC2NKTlvU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=koxOXqqxqBhG1iY39OYEdtTvaVaBI/gEoGEsEgoA6TKNOo9nNacBeFX3+TdO06rOtACCweW9d8qe9gB/9exaR6F6FS939kDwfyuiqze74d79scrAH3dxIkel1jhiFgxGV8YRCf+bvwBgMJA1SJ1KW3nOA2TPXpLxg380hMjJNac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=rITZwrpM; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721466908; x=1722071708; i=markus.elfring@web.de;
	bh=+sXR6PUsTXeL04iALMtFOwco/49eP00xt8gZ0L9q2+I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rITZwrpMYme6ZO3351nEn23Cf9dVL65kX9yzWZC7O/YzR11lZwPMTtQ6i7aGcj8u
	 YUmVwr1aQSrse6J5Svmu5kxYgGUj+fDwJFavRlqYRoiofGqdgxYSrH29dAQ2tp6ne
	 lEcqYFNqUwWSrtdik76iDlykgAES32Y+h3ik2W0uhJc0aihDGMf+F3iSihz8sOCCn
	 ToUbgZOxlyOrC1m8zWpo2ayZTfqHrIQ0vHTiMaCGJGaMN0jjeawo3Up8zVgGgTy+g
	 tA8H8OfgcQiSLqF/i3DPR9ZzZNlmr3d8CYKsxKq+GSimr5ua0YUENeZNT18U5hp2d
	 X+yd6ksS7KM9TCJrSg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQPdr-1si6t31JCb-00M4DX; Sat, 20
 Jul 2024 11:15:08 +0200
Message-ID: <b90c3712-4651-40ec-9826-ac0d620d2fb8@web.de>
Date: Sat, 20 Jul 2024 11:15:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Lizhi Hou <lizhi.hou@amd.com>, Min Ma <min.ma@amd.com>,
 dri-devel@lists.freedesktop.org, Oded Gabbay <ogabbay@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Max Zhen <max.zhen@amd.com>,
 Sonal Santan <sonal.santan@amd.com>
References: <20240719175128.2257677-4-lizhi.hou@amd.com>
Subject: Re: [PATCH 03/10] accel/amdxdna: Add hardware resource solver
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240719175128.2257677-4-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kPXzztl3n/DrfsXLj7SvU27XgWu2xgndp1WKDgdRA63xbLPiY0m
 P0bbCIMqlNibuBwv9Hz+KakiVQu+YWiSb17dZeBVRXYruFzXb0gojzaNlNQFAi+BZdmH5U2
 +eaYQzzZF9oV30NGp2U+m8RH/xdiSkO5VDoq07zWPqh9sY0a+N0/ivfua38uDuW7Nlghxjh
 nrHSp5nNtXSA3qvCikm8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Uuq00lZaWJQ=;hC4XyI5qzyxA2SSArq09fydESzM
 lil/NkdM+2e/pobXIe1iOPAgeKnMjFpgc8uq0aTLe5f/8XZNrVHs7CHsRI8w2yuzLHZfLgoGv
 x1BBudy6O9n+9IMBs6wReOCYCT9KpxR3sjugGz3tfU7U27qWk59NRol3AKPF8tzl7W8rAqwii
 SYM4/bVmeKc2O4c+bL/Qi1vLXwRP/29Oe8KnLUCOFXfWmLMW4ZiNgCYLGFUDRILLhlpSsh9bu
 da5IOBRuEwiK7yM9IOX/JNjq4m2TqXsAt4e+iEU8paoeMpot+PaozsWwswJ+oz2U3Xhf9fS94
 kI5d1WBQk4ydGBqiFDaLiQE4uwpZqnh0yjfAcxfnBENoybfNt5lp3CSrWsjbuKWnkRkMK7WR7
 LM2Ar/6KkQ6hJSbfJrrjVgWeVTx2at94C80t7zVPrysNDggGG+WnOvv05YULrPPD7tsnMk2EE
 ANvnw0ASk3JDuK+REi+yPDJTJsydH89VkFrDNnX5t7NQUL/Eryotglgphgq1S/OX2/ziwPx5A
 nvVQBGqzWKN2gyWykSC2LWQ21KNt2dkovXn95cdfq4wZ95En7HZVv+DTZTawLcoV9iKB7s+1J
 /UerbMs/oM0yl733v+p4FBCLsnqVKQR/wrB332xNhTyCI5+z9ZRapSb+CLsqePYIuXentFUNz
 MnVClfa4zxjxlF/lzFUhxytcMqfI9Pc/XOx0spL2oChDsZoDmmstk9csyCln4ALnnNtdHjP/S
 BuDtYrd4s2ekUxfj6AjUoJ4J3qq1UZTZzUJXuS93/Ci6FrP/YK+p3udR5RYhWGN28AFOAtbbT
 IeBH9NorS8xcXzQMpvmE563w==

> The AI Engine consists of 2D array of tiles arranged as columns. The
> resource solver provides the interfaces to manage allocation of the tile
> columns for a hardware context. The basic column allocation and release
> functions are provided.

Can such a change description be improved with imperative wordings?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10#n94


=E2=80=A6
> +++ b/drivers/accel/amdxdna/aie2_solver.c
> @@ -0,0 +1,329 @@
=E2=80=A6
> +void *xrsm_init(struct init_config *cfg)
> +{
=E2=80=A6
> +	memcpy(&xrs->cfg, cfg, sizeof(struct init_config));
=E2=80=A6

Please specify a pointer =E2=80=9Cdereference=E2=80=9D instead of the data=
 structure name.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.10#n953

Regards,
Markus

