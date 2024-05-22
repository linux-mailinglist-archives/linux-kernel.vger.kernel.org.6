Return-Path: <linux-kernel+bounces-186533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 018E78CC54D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D747B20F64
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9BD1420D1;
	Wed, 22 May 2024 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5/TqdKb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379741F17B;
	Wed, 22 May 2024 17:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716397532; cv=none; b=GYshaQrm5AdMteLQuaIH6HU3ufJej4x4vs+KNJ8ZxYnZH+5zz3qTuHlLQHQSv4RY7/hfJBgzH3ShGzVC+3rfhzHafanfdpogF5i6KEA1vKTXQDoQo3JzERsUNq04R05UdE+CXvNPmBq5kFda+wTD0IGSbbM0hT8aLRI+shZwiw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716397532; c=relaxed/simple;
	bh=n+bl6qffvfcDmfvyQ5KKICcroj6hZl/cSV5hmi5RmH0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uGC7XNhjkHbZBRYr6d8WXWqtZF0cEgwiXRWcgckpni0fy8dT4bCiavI7vtpyxgbCreRd2CzUSwH/7sq5MFzwXN4N12Zt+IKOmXn+oc7hBytuQZ2SSTKfTY9GePMuV/P4jCHKb+KZi5P8BpSdomo56Z8Cb2gGQjzocJYgrc/2lZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5/TqdKb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63601C2BBFC;
	Wed, 22 May 2024 17:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716397530;
	bh=n+bl6qffvfcDmfvyQ5KKICcroj6hZl/cSV5hmi5RmH0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=e5/TqdKbduEfbop/yeQg5/GSqLX6vWsJeN/dzQ3ZGNxUZIU935+6iJTB25f6eZmtr
	 YBzvRhFbXuUeMZnPdxaRAPHqbPYRq0L58V8WHe7seX99QV6cYZGdfj/qBQgqbqEZ1W
	 0MYklGrEuW9i7aVt8WPMuVVVLj9YT8xdBDh+C/UkUx1cWvVsp7DXXxk24IXnvafeb5
	 +QtB+k4qzKPtG1HGHqL2ncyVD101QFRMIHmgFwoWe23o6SVb8IsIWkt0+5o7g3nJjL
	 iD9oB8cNsRkAyP5k4RLLh3TAV1EatT7Pc9/Omr+iS2bcy9MN2QC9dgrXzI9C43kKxx
	 uRopnj2oP0dRQ==
Message-ID: <60989c44-6d16-4698-bf3f-b3c5dcd7b3e0@kernel.org>
Date: Wed, 22 May 2024 19:05:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: DT schema bindings conversion mentorships (was Re: [PATCH v5] ASoC:
 dt-bindings: omap-mcpdm: Convert to DT schema)
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Daniel Baluta <daniel.baluta@nxp.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Julia Lawall
 <julia.lawall@inria.fr>, Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20240522075245.388-1-bavishimithil@gmail.com>
 <0594944d-c158-4840-8724-b3f2edaab1ca@gmail.com>
 <4f722e53-011f-4176-b6af-080522165007@kernel.org>
 <bb44d588-9316-4509-b545-9bbaa2d240cb@gmail.com>
 <3c6c5be1-fb8e-4bf0-9f58-cfb09672e8c1@kernel.org>
 <d999bc26-9bb1-44a8-92a3-bcbe14c5a1c3@gmail.com>
 <58ada5ce-5c02-4ff5-8bdd-d6556c9d141f@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <58ada5ce-5c02-4ff5-8bdd-d6556c9d141f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/05/2024 18:42, Krzysztof Kozlowski wrote:
>> Yes, the binding document was neglected pretty badly but when converting
>> to yaml it has to be correct since that will have ripple effect on
>> existing dts/dtsi files.
> 
> Yep. And testing DTS should clearly show that conversion leads to
> incomplete binding.
> 
>>
>>> I assume the DTS was validated with the binding. Isn't the case here?
> 
> Mithil Bavishi,
> Are you sure you tested the DTS?

Dear Daniel, Shuah, Julia, Javier and other mentorship managers,

I see some contributions regarding Devicetree bindings which look like
efforts of some mentorship programs. It's great, I really like it. Only
sadness is that no one ever asked us, Devicetree maintainers, about some
sort of guidelines. This leads to sub-optimal allocation of tasks and
quite a strain on reviewers side: for example we receive contributions
which were never tested (tested as in make target - make
dt_binding_check). Or people converted bindings which really do not
matter thus their work soon will become obsolete.

If there are still such active programs, please be sure that mentees
follow these guidelines:

https://social.kernel.org/notice/Ai9hYRUKo8suzX3zNY

1. Please convert bindings which have active DTS users. First choose
bindings with DTS built by arm64 defconfig, then next choice by arm
multi_v7 defconfig. Then any other ARM or different architecture DTS.

2. Be sure dt_bindings_check (including yamllint) and checkpatch pass
without any warnings. See writing-schema.rst document.

3. Be sure DTS using these bindings passes dtbs_check validation. If
this means binding needs to be adapted during conversion, mention
briefly in the commit message changes done comparing to pure TXT->DT
schema conversion.

Best regards,
Krzysztof


