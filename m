Return-Path: <linux-kernel+bounces-317044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B52C96D88F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86762B23FD4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B4F19AD8C;
	Thu,  5 Sep 2024 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="GDdNwnAm"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF52A1925BD;
	Thu,  5 Sep 2024 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539392; cv=none; b=MlYjAlC9ot84IriKZeiitJl4nht53piDnKSfXZNQlWFBoNr4gpu4ZNl0B7BIl2DoMml3tqajl/Df6HE4mABXvJIZLgBts9MpngwGy1bFScQCTkWMlN/t0b+Woo7eiuft7h4DmOVstWhDY6rVR1In6YQ0WH6NuQwvYXruLqHJLR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539392; c=relaxed/simple;
	bh=14MIEGOCtz/10JlhbBiflIQgkVzb0dyS/Kn3Kdmj1K4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=R1yVltlsUmeP4bGkTOOi2nGtM6QtycAei8UuL8KvABGB/6vOtJaIjPPG/JAKNVnQqtUyndXe7bMI/2h+4vWiq4KBAfFjOqOAya8v/ciX/nn8Yd+eUYscQKYlwwx7UlJ0z8wqNDDYU27456XJN0Mmt7jCCag7oxyiVm16njnH39M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=GDdNwnAm; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1725539388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pcIg9aZgeBTSSImKsZL/JCCaARaF7G8ZPmkIlXT3URU=;
	b=GDdNwnAmqU69jkjpbeM2mhK9/fAB9Nk2Amq7RAE6U5QLrn+XzjHMw6heeCiPHwfTdrNw7V
	ZX7Yk6wSUzNx+RSOAQn6OTD4+sc1aWS6Ss5gXWiu2jYv0delZnkFhmdn/Q4YASKrGoawX9
	MqnHOAC07O95fsjJxGBPeA/Cx0iYddubPFmFopNAMX3KxLYP3z06+xZ0RhQ8KGsoEB5pNd
	Mzkk0eD3J/rkxM2lAxPuGpDQ+ZdujooUpM2JnjkPFyetIv1HbBgRwU56WEPfG58lwKdQb0
	+lKqatEDuBh7fXCNLmyhveAi3lo3DX5jtNTEbkWhOUd9GRHSoHYFMA9ubsF5Qw==
Date: Thu, 05 Sep 2024 14:29:47 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: wens@csie.org
Cc: Andre Przywara <andre.przywara@arm.com>, linux-sunxi@lists.linux.dev,
 jernej.skrabec@gmail.com, samuel@sholland.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Move CPU OPPs to the SoC dtsi
 file
In-Reply-To: <CAGb2v65h8zaxoEKeqdT8BZD9t=4gf0QM7zBnhuDoiEhHQLKduw@mail.gmail.com>
References: <92ebc9cba6eb669df73efd478e4f5745056a4ce5.1723614345.git.dsimic@manjaro.org>
 <CAGb2v678Z8TMKZmBmmd5hW9XBdKw9KD+JgrsMm5e8sSoYOq3wA@mail.gmail.com>
 <21d6e75bc33ef2b7f27932fee1b8de05@manjaro.org>
 <20240815181508.6800e205@donnerap.manchester.arm.com>
 <06cec3fc98e930bedc8ea5bfde776b3d@manjaro.org>
 <0fc37f3074a3e99c15a2f441194b7032@manjaro.org>
 <CAGb2v65h8zaxoEKeqdT8BZD9t=4gf0QM7zBnhuDoiEhHQLKduw@mail.gmail.com>
Message-ID: <3e0d4e26d724d7496cb5f570e1813433@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Chen-Yu,

On 2024-09-05 14:26, Chen-Yu Tsai wrote:
> Hi,
> 
> On Thu, Sep 5, 2024 at 8:17 PM Dragan Simic <dsimic@manjaro.org> wrote:
>> 
>> Hello,
>> 
>> Just checking, any further thoughts about this patch?
> 
> Sorry, but I feel like it's not really worth the churn. There's not
> really a problem to be solved here. What you are arguing for is more
> about aesthetics, and we could argue that having them separate makes
> it easier to read and turn on/off.
> 
> And even though the GPU OPPs are in the dtsi, it's just one OPP acting
> as a default clock rate.

Thanks for your response, I understand why it isn't acceptable.


>> On 2024-08-17 06:25, Dragan Simic wrote:
>> > Hello Andre,
>> >
>> > On 2024-08-15 19:15, Andre Przywara wrote:
>> >> On Thu, 15 Aug 2024 18:34:58 +0200
>> >> Dragan Simic <dsimic@manjaro.org> wrote:
>> >>> On 2024-08-14 18:11, Chen-Yu Tsai wrote:
>> >>> > On Wed, Aug 14, 2024 at 1:52 PM Dragan Simic <dsimic@manjaro.org>
>> >>> > wrote:
>> >>> >>
>> >>> >> Move the Allwinner A64 CPU OPPs to the A64 SoC dtsi file and,
>> >>> >> consequently,
>> >>> >> adjust the contents of the affected board dts(i) files appropriately,
>> >>> >> to
>> >>> >> "encapsulate" the CPU OPPs into the SoC dtsi file.
>> >>> >>
>> >>> >> Moving the CPU OPPs to the SoC dtsi file, instead of requiring the
>> >>> >> board
>> >>> >> dts(i) files to include both the SoC dtsi file and the CPU OPP dtsi
>> >>> >> file,
>> >>> >> reduces the possibility for incomplete SoC data inclusion and improves
>> >>> >> the
>> >>> >> overall hierarchical representation of data.  Moreover, the CPU OPPs
>> >>> >> are
>> >>> >> not used anywhere but together with the SoC dtsi file, which
>> >>> >> additionally
>> >>> >> justifies the folding of the CPU OPPs into the SoC dtsi file.
>> >>> >>
>> >>> >> No functional changes are introduced, which was validated by
>> >>> >> decompiling and
>> >>> >> comparing all affected board dtb files before and after these changes.
>> >>> >>  When
>> >>> >> compared with the decompiled original dtb files, the updated dtb files
>> >>> >> have
>> >>> >> some of their blocks shuffled around a bit and some of their phandles
>> >>> >> have
>> >>> >> different values, as a result of the changes to the order in which the
>> >>> >> building blocks from the parent dtsi files are included into them, but
>> >>> >> they
>> >>> >> still effectively remain the same as the originals.
>> >>> >
>> >>> > IIRC, this was a conscious decision requiring board dts files to set
>> >>> > their
>> >>> > CPU supply before OPPs are given. The bootloader does not boot the SoC
>> >>> > at the highest possible OPP / regulator voltage, so if the OPPs are
>> >>> > given
>> >>> > but the supply is not, the kernel will attempt to raise the frequency
>> >>> > beyond what the current voltage can supply, causing it to hang.
>> >>
>> >> Yes, this is what I remember as well: this forces boards to opt in to
>> >> DVFS, otherwise they get a fixed 816 MHz. Since there is only one OPP
>> >> table for all boards with that SoC, I think it's reasonable to ask for
>> >> this, since the cooling could not be adequate for higher frequencies
>> >> in
>> >> the first place, or the power supply is not up to par.
>> >
>> > If the cooling isn't capable enough to dissipate the additional heat
>> > generated at higher frequencies, the thermal governor is there to
>> > handle
>> > that by lowering the operating frequency.  If the PSU isn't capable to
>> > provide an additional watt or two, I think a better PSU is needed. :)
>> > No reasonably sized PSU should work at ~100% of its power output.
>> >
>> > On top of that, all currently supported A64-based boards have the CPU
>> > OPPs defined and CPU DVFS enabled, so no such issues are possible
>> > there.
>> > Though, there could be some issues with new A64-based boards, which is
>> > discussed further below.
>> >
>> >>> > Now that all existing boards have it properly enabled, there should be
>> >>> > no
>> >>> > need for this. However I would appreciate a second opinion.
>> >>
>> >> Well, since there is no way to opt *out* now, I am somewhat reluctant
>> >> to
>> >> just have this. What is the actual problem we are solving here? After
>> >> all
>> >> there is just one OPP table for all A64 boards, so there is less
>> >> confusion
>> >> about what to include in each board file. Which IIUC is a more
>> >> complicated
>> >> situation on the Rockchip side.
>> >
>> > Well, this patch doesn't solve some real problem, but it makes the
>> > things
>> > neater and a bit more clean.  The things are more complicated with
>> > Rockchip
>> > SoCs, but following the concept of "encapsulating" the CPU OPPs into
>> > the
>> > A64 SoC dtsi makes things neater.  Moreover, the A64 GPU OPPs are
>> > already
>> > in the A64 SoC dtsi, so we could also say that folding the A64 CPU OPPs
>> > into the SoC dtsi follows the A64 GPU OPPs.
>> >
>> >> I still have to try "operating-points-v2", but at least on the H616
>> >> side
>> >> putting a 'status = "disabled";' into the OPP node didn't prevent it
>> >> from
>> >> probing. Otherwise this would have been a nice compromise, I think.
>> >>
>> >>> Good point, thanks for the clarification.  This is quite similar to
>> >>> how
>> >>> board dts(i) files for Rockchip SoCs need to enable the SoC's
>> >>> built-in
>> >>> TSADC for temperature sensing, before the CPU thermal throttling can
>> >>> actually work and prevent the SoC from overheating, etc.
>> >>>
>> >>> The consensus for Rockchip boards is that it's up to the authors and
>> >>> reviewers of the board dts(i) files to make sure that the built-in
>> >>> TSADC
>> >>> is enabled, etc.  With that approach in mind, and knowing that all
>> >>> Allwinner
>> >>> A64 board dts(i) files are in good shape when it comes to the
>> >>> associated
>> >>> voltage regulators, I think it's fine to follow the same approach of
>> >>> "encapsulating" the CPU OPPs into the A64 SoC dtsi file.
>> >>
>> >> As mentioned above, I am not so sure about this. With this patch here,
>> >> *every* board gets DVFS. And while this seems to be fine when looking
>> >> at
>> >> the current DTs in the tree (which have it anyway), it creates a
>> >> potentially dangerous situation for new boards.
>> >>
>> >> So pragmatically speaking, this patch would be fine, but it leaves me
>> >> a
>> >> bit uneasy about future or downstream boards.
>> >
>> > Frankly, I wouldn't be worried about that.  When a new A64-based board
>> > is added, it should be verified that CPU DVFS works as expected, etc.,
>> > before the new board dts file is accepted upstream.
>> >
>> > Maybe we could take into account some possible issues when someone
>> > starts
>> > putting together a new A64-based board dts file, but there are already
>> > many dangerous things that someone can do in the process, such as
>> > messing
>> > up various regulators and voltages unrelated to the CPU DVFS, so
>> > everyone
>> > putting a new board dts file together simply have to know what are they
>> > doing.  I see no way for escaping from that need.
>> >
> 
> [...]

