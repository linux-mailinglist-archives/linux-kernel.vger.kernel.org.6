Return-Path: <linux-kernel+bounces-317039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CF896D880
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A22288A68
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9980C19B3E2;
	Thu,  5 Sep 2024 12:26:36 +0000 (UTC)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF761E489;
	Thu,  5 Sep 2024 12:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539196; cv=none; b=Jto97dCqS8FrwHQlhPSVh335O6CAqLkfG3cWUBj8szLOZ174EbQ0cAwf3RWJmPiMIaH3yqHPs4UY3sm+VYb9viqvUHHXW+Q2ULje5KRYsCLY4WAgSHbYHmSKqJwtn1VfwUiGCSx/zbLF3jx/rReLu4QZl/OQ/KHewe3OrUoZTHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539196; c=relaxed/simple;
	bh=W1ZFVtfXUXJKRy2AgMkJ1X+p+rD/HA7gpZ1snU/jBjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7mV2sUFlTugzXbbuVyMc0LUE8KQnbE/C82zN2v6HmGYuvWDaK2Uy3YXfxuPYTymGptZ00K8yWh1CxgQ91o5jkGIimn3MwJQFtYbYYtiF8E83QAJorM/+gboyjiCHr3FhZeQZlOcpqvD05uJ2sPIdfZ/pW7Nu3lOMCclLTi0OXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f50f1d864fso9042341fa.1;
        Thu, 05 Sep 2024 05:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725539191; x=1726143991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HC05u3G3MyxRvr1uTN/6BxkEJxTP1nCL1t/sOLNB64U=;
        b=eCqxBm5NMYiKW4r+hL7S4mG4LEmBpMgOPvSPUCiUvbv9jTMjoEMqB1YSsshpCAa0hQ
         +/QOD1F+8XPgkeVC9BVbqcsWGotX9qAYQVGIf9cxm4rpGCwcUPGjy44h0fQwuAyE5kAM
         wg1ZBEPYgi+9iqSBuEWkeaeGwFOUyclgQcQV4esVjrXIIJEtHK4TIzUWUWLM9QEycB1L
         jymC3fLDueSLZWQNpAqUpJ5ZGnIBiOFD5MEMjqGoRsuVnjvOW/4ELDu0SmClXXdDnLfb
         XkSc1njiSXv6/bGOtgkKQD7dBvMpTKtwRYk0bbiyswkAZ3SlfPqUoQ9+gvzrKY03dtrM
         LnNw==
X-Forwarded-Encrypted: i=1; AJvYcCUBlQR7Mcrwen47dizCdVL+DNpMlgxbqIVQ0B04zVwDdPl1C4eC4hkT2ETUpviWvbbbfw0x2bTfu/0f@vger.kernel.org, AJvYcCVkZMHqvpJaeyLGquPCsGwvHlq81eA/knh4lx5qfSgshsGxUUBXH+xMJSGwkUx/evj5LAjAkLhvAv+Lq8K0@vger.kernel.org
X-Gm-Message-State: AOJu0YwXy7kV6hIVo+VIGCxv2dE69uwGKbnEi0G7C5OWmyHvmVhZRzx0
	R8tkR5Mxi9kiwNYIlnCUHwbiyFnSoAV3FaeY5Qvus/eAYDA3i1cDz4L032BT
X-Google-Smtp-Source: AGHT+IFidjmz8bYzNvnlm0veyB4ythVx7n2k8zOOVYKBAAxW4yoXJkyJSBBrfL5MYoDqxxnAVVZ8PQ==
X-Received: by 2002:a2e:a544:0:b0:2f6:43fd:f870 with SMTP id 38308e7fff4ca-2f643fdf9abmr76487821fa.31.1725539190050;
        Thu, 05 Sep 2024 05:26:30 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f614ed6c91sm28498241fa.18.2024.09.05.05.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 05:26:29 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f50f1d864fso9041711fa.1;
        Thu, 05 Sep 2024 05:26:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULIB3CGGWaeBY2PZrT3eJD0G57Hfa2BQ70RkAkLMo0cSqJ0YCmk0QmeojU7FyzxzOXigXu/DrBjjsfII19@vger.kernel.org, AJvYcCX6wSOlHvSbdkTptfUjBcvxXqxlmOOZzb2DO1uvAE/+GMgwwl4Thv6TmvgKoxIWjlEL8E4aOhAzw1LX@vger.kernel.org
X-Received: by 2002:a05:651c:1505:b0:2ef:2e90:29f9 with SMTP id
 38308e7fff4ca-2f629041b9amr99979771fa.17.1725539188843; Thu, 05 Sep 2024
 05:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <92ebc9cba6eb669df73efd478e4f5745056a4ce5.1723614345.git.dsimic@manjaro.org>
 <CAGb2v678Z8TMKZmBmmd5hW9XBdKw9KD+JgrsMm5e8sSoYOq3wA@mail.gmail.com>
 <21d6e75bc33ef2b7f27932fee1b8de05@manjaro.org> <20240815181508.6800e205@donnerap.manchester.arm.com>
 <06cec3fc98e930bedc8ea5bfde776b3d@manjaro.org> <0fc37f3074a3e99c15a2f441194b7032@manjaro.org>
In-Reply-To: <0fc37f3074a3e99c15a2f441194b7032@manjaro.org>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 5 Sep 2024 20:26:15 +0800
X-Gmail-Original-Message-ID: <CAGb2v65h8zaxoEKeqdT8BZD9t=4gf0QM7zBnhuDoiEhHQLKduw@mail.gmail.com>
Message-ID: <CAGb2v65h8zaxoEKeqdT8BZD9t=4gf0QM7zBnhuDoiEhHQLKduw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Move CPU OPPs to the SoC dtsi file
To: Dragan Simic <dsimic@manjaro.org>
Cc: Andre Przywara <andre.przywara@arm.com>, linux-sunxi@lists.linux.dev, 
	jernej.skrabec@gmail.com, samuel@sholland.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 5, 2024 at 8:17=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> wr=
ote:
>
> Hello,
>
> Just checking, any further thoughts about this patch?

Sorry, but I feel like it's not really worth the churn. There's not
really a problem to be solved here. What you are arguing for is more
about aesthetics, and we could argue that having them separate makes
it easier to read and turn on/off.

And even though the GPU OPPs are in the dtsi, it's just one OPP acting
as a default clock rate.


ChenYu

> On 2024-08-17 06:25, Dragan Simic wrote:
> > Hello Andre,
> >
> > On 2024-08-15 19:15, Andre Przywara wrote:
> >> On Thu, 15 Aug 2024 18:34:58 +0200
> >> Dragan Simic <dsimic@manjaro.org> wrote:
> >>> On 2024-08-14 18:11, Chen-Yu Tsai wrote:
> >>> > On Wed, Aug 14, 2024 at 1:52=E2=80=AFPM Dragan Simic <dsimic@manjar=
o.org>
> >>> > wrote:
> >>> >>
> >>> >> Move the Allwinner A64 CPU OPPs to the A64 SoC dtsi file and,
> >>> >> consequently,
> >>> >> adjust the contents of the affected board dts(i) files appropriate=
ly,
> >>> >> to
> >>> >> "encapsulate" the CPU OPPs into the SoC dtsi file.
> >>> >>
> >>> >> Moving the CPU OPPs to the SoC dtsi file, instead of requiring the
> >>> >> board
> >>> >> dts(i) files to include both the SoC dtsi file and the CPU OPP dts=
i
> >>> >> file,
> >>> >> reduces the possibility for incomplete SoC data inclusion and impr=
oves
> >>> >> the
> >>> >> overall hierarchical representation of data.  Moreover, the CPU OP=
Ps
> >>> >> are
> >>> >> not used anywhere but together with the SoC dtsi file, which
> >>> >> additionally
> >>> >> justifies the folding of the CPU OPPs into the SoC dtsi file.
> >>> >>
> >>> >> No functional changes are introduced, which was validated by
> >>> >> decompiling and
> >>> >> comparing all affected board dtb files before and after these chan=
ges.
> >>> >>  When
> >>> >> compared with the decompiled original dtb files, the updated dtb f=
iles
> >>> >> have
> >>> >> some of their blocks shuffled around a bit and some of their phand=
les
> >>> >> have
> >>> >> different values, as a result of the changes to the order in which=
 the
> >>> >> building blocks from the parent dtsi files are included into them,=
 but
> >>> >> they
> >>> >> still effectively remain the same as the originals.
> >>> >
> >>> > IIRC, this was a conscious decision requiring board dts files to se=
t
> >>> > their
> >>> > CPU supply before OPPs are given. The bootloader does not boot the =
SoC
> >>> > at the highest possible OPP / regulator voltage, so if the OPPs are
> >>> > given
> >>> > but the supply is not, the kernel will attempt to raise the frequen=
cy
> >>> > beyond what the current voltage can supply, causing it to hang.
> >>
> >> Yes, this is what I remember as well: this forces boards to opt in to
> >> DVFS, otherwise they get a fixed 816 MHz. Since there is only one OPP
> >> table for all boards with that SoC, I think it's reasonable to ask for
> >> this, since the cooling could not be adequate for higher frequencies
> >> in
> >> the first place, or the power supply is not up to par.
> >
> > If the cooling isn't capable enough to dissipate the additional heat
> > generated at higher frequencies, the thermal governor is there to
> > handle
> > that by lowering the operating frequency.  If the PSU isn't capable to
> > provide an additional watt or two, I think a better PSU is needed. :)
> > No reasonably sized PSU should work at ~100% of its power output.
> >
> > On top of that, all currently supported A64-based boards have the CPU
> > OPPs defined and CPU DVFS enabled, so no such issues are possible
> > there.
> > Though, there could be some issues with new A64-based boards, which is
> > discussed further below.
> >
> >>> > Now that all existing boards have it properly enabled, there should=
 be
> >>> > no
> >>> > need for this. However I would appreciate a second opinion.
> >>
> >> Well, since there is no way to opt *out* now, I am somewhat reluctant
> >> to
> >> just have this. What is the actual problem we are solving here? After
> >> all
> >> there is just one OPP table for all A64 boards, so there is less
> >> confusion
> >> about what to include in each board file. Which IIUC is a more
> >> complicated
> >> situation on the Rockchip side.
> >
> > Well, this patch doesn't solve some real problem, but it makes the
> > things
> > neater and a bit more clean.  The things are more complicated with
> > Rockchip
> > SoCs, but following the concept of "encapsulating" the CPU OPPs into
> > the
> > A64 SoC dtsi makes things neater.  Moreover, the A64 GPU OPPs are
> > already
> > in the A64 SoC dtsi, so we could also say that folding the A64 CPU OPPs
> > into the SoC dtsi follows the A64 GPU OPPs.
> >
> >> I still have to try "operating-points-v2", but at least on the H616
> >> side
> >> putting a 'status =3D "disabled";' into the OPP node didn't prevent it
> >> from
> >> probing. Otherwise this would have been a nice compromise, I think.
> >>
> >>> Good point, thanks for the clarification.  This is quite similar to
> >>> how
> >>> board dts(i) files for Rockchip SoCs need to enable the SoC's
> >>> built-in
> >>> TSADC for temperature sensing, before the CPU thermal throttling can
> >>> actually work and prevent the SoC from overheating, etc.
> >>>
> >>> The consensus for Rockchip boards is that it's up to the authors and
> >>> reviewers of the board dts(i) files to make sure that the built-in
> >>> TSADC
> >>> is enabled, etc.  With that approach in mind, and knowing that all
> >>> Allwinner
> >>> A64 board dts(i) files are in good shape when it comes to the
> >>> associated
> >>> voltage regulators, I think it's fine to follow the same approach of
> >>> "encapsulating" the CPU OPPs into the A64 SoC dtsi file.
> >>
> >> As mentioned above, I am not so sure about this. With this patch here,
> >> *every* board gets DVFS. And while this seems to be fine when looking
> >> at
> >> the current DTs in the tree (which have it anyway), it creates a
> >> potentially dangerous situation for new boards.
> >>
> >> So pragmatically speaking, this patch would be fine, but it leaves me
> >> a
> >> bit uneasy about future or downstream boards.
> >
> > Frankly, I wouldn't be worried about that.  When a new A64-based board
> > is added, it should be verified that CPU DVFS works as expected, etc.,
> > before the new board dts file is accepted upstream.
> >
> > Maybe we could take into account some possible issues when someone
> > starts
> > putting together a new A64-based board dts file, but there are already
> > many dangerous things that someone can do in the process, such as
> > messing
> > up various regulators and voltages unrelated to the CPU DVFS, so
> > everyone
> > putting a new board dts file together simply have to know what are they
> > doing.  I see no way for escaping from that need.
> >

[...]

