Return-Path: <linux-kernel+bounces-543311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F1FA4D423
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B391701A4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57711F55ED;
	Tue,  4 Mar 2025 06:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="lDzKW4rR"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641E213C67C;
	Tue,  4 Mar 2025 06:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741071458; cv=none; b=DaOrcniVkpqoR6YsNIv7fhEUX6ToubvTWSeAeW2DqmMYVMhTmBR4FOhJsZ5SINpnM2rWRJpF6kOoOjR+F0CmKb1fnz0gqH4s+U+gl1jHtnWXVBST2OJcN4wK5dgQ/JF3fJaeTYzCmscj3Dneg1D37oQo7q6fEq4IOYhYz1dWjSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741071458; c=relaxed/simple;
	bh=NGgj3H12eRG8fPkq0w92K4x573SWk8Mg6RvYiXt345o=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=CZAzEQKONxwPH12SzqJPvI8LVmW1xEYqz1TZOlEfyZx9H9A7BHuWEeRqnktoLQzbOs1ixh0WDFKqjq/9vawE0z6zNRwVZUymFn6sUXO+rkzHLARTokNMl6WnT3209gqsFqD41Flvjy9rlxAvH5l0zMwgpbCvx4NzstQu0Kxj/UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=lDzKW4rR; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1741071454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8nD2IpkXkau4WZUb38wSv5b3eflHb98MypZT0H60FFg=;
	b=lDzKW4rRCXkn4A9giJuVYXk/56OSuMDeqWKuBKTKaAClAxGeLBBF9W47S230gt0MWAhk3F
	YqPOG1FKZIVKHOoVfOYADY5IpGhwPnVT4jexj4LLepZOFzlvrciptSUL9hwsfKGDipKXoh
	d+26AMvkJzxfsi35CgFrMIYtJULL/DpfNGDo5BK4pyp1E8g4GHyBF6N9hHoZUIqrfH5v9G
	eWJudVjnXxT6G4KpViWTpSiegwDL+qsBXbTGHVkxmJSmclq91bsd7ULkG163sEwzO2+ob0
	ACdr9FE+3HARZvksja5hVH+Wp73Gla89bYGUmTBOAd/pKA0UFhwvh7aOqc9eEg==
Date: Tue, 04 Mar 2025 07:57:34 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, didi.debian@cknow.org, chris@z9.de
Subject: Re: [PATCH v2 0/2] Slightly improve hardware description of Pine64
 RockPro64
In-Reply-To: <757afa87255212dfa5abf4c0e31deb08@manjaro.org>
References: <cover.1740941097.git.dsimic@manjaro.org>
 <174104113599.8946.16805724674396090918.b4-ty@sntech.de>
 <757afa87255212dfa5abf4c0e31deb08@manjaro.org>
Message-ID: <dff9509bcbe9be10b2df454c2dabc289@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2025-03-04 07:44, Dragan Simic wrote:
> On 2025-03-03 23:36, Heiko Stuebner wrote:
>> On Sun, 02 Mar 2025 19:48:02 +0100, Dragan Simic wrote:
>>> This is a small series that introduces small improvements to the way
>>> Pine64 RockPro64 [1] single-board-computer is described in the DT 
>>> files.
>>> This applies to both production-run revisions of the RockPro64.
>>> 
>>> The introduced improvements boil down to eliminating some warnings 
>>> from
>>> the kernel log, by adding a previously undefined regulator and by 
>>> adding
>>> some previously missing references to the regulators.
>>> 
>>> [...]
>> 
>> Applied, thanks!
>> 
>> [1/2] arm64: dts: rockchip: Add avdd HDMI supplies to RockPro64 board 
>> dtsi
>>       commit: bd1c959f37f384b477f51572331b0dc828bd009a
>> [2/2] arm64: dts: rockchip: Add missing PCIe supplies to RockPro64 
>> board dtsi
>>       commit: 64ef4a4320e7aa3f0f267e01f170f52b90bf0b1b
>> 
>> I've moved the pcie12v supply up one line.
>> While in a mathematical sense it's true 12 > 3.3, we're sorting
>> alphabetical, so it's 1?? < 3?? .
>> 
>> And yes I sympathize with 3.3 < 12, but also have come to appreciate 
>> not
>> having overly many special cases :-)
> 
> Great, thanks! :)
> 
> I'm fine with the alphabetical ordering, albeit with some caveats
> described below, but the following part of the patch description
> should also be removed, if possible, so the patch description fully
> matches the introduced changes:
> 
>   Shuffle and reorder the "vpcie*-supply" properties a bit, so they're 
> sorted
>   alphanumerically, which is a bit more logical and more useful than 
> having
>   these properties listed in their strict alphabetical order.
> 
> Admittedly, the patch itself indeed looks nicer [1] with the
> alphabetical ordering, :) (which is quasi-alphabetical, actually,
> please see below) but it might be better to have the DT guidelines
> adjusted to specify alphanumerical ordering as well.  Even ls(1)
> can sort filenames alphanumerically, with its "-v" option that
> performs "natural sort of (version) numbers within text". [2]
> 
> The real trouble is that, if we were to apply the alphabetical
> ordering strictly, we'd end up with the following order of node
> properties in which 12 is before 1.8 and 3.3, which IMHO doesn't
> make much sense:
> 
>   vpcie0v9-supply = <&vcca_0v9>;
>   vpcie12v-supply = <&vcc12v_dcin>;
>   vpcie1v8-supply = <&vcca_1v8>;
>   vpcie3v3-supply = <&vcc3v3_pcie>;
> 
> I'm hoping you'll agree that specifying alphanumerical ordering
> for the properties in the DTS coding style is the way to go, just
> like it's already specified for the ordering of the nodes.  I'll
> go ahead and submit an appropriate patch for the DT guidelines.
> 
> [1] 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?id=64ef4a4320e7aa3f0f267e01f170f52b90bf0b1b
> [2] https://man.archlinux.org/man/ls.1.en#v

For future reference and for anyone interested, here's a link to
the above-mentioned DTS coding style patch:

https://lore.kernel.org/linux-kernel/09d6f2fc111b3d6e58987336944f93ec36b65118.1741071107.git.dsimic@manjaro.org/T/#u

