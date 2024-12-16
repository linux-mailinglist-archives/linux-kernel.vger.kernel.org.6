Return-Path: <linux-kernel+bounces-447536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A194D9F33E2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1DC7188AD00
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8D01304AB;
	Mon, 16 Dec 2024 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpUw+ffu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ECA84A2F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734361155; cv=none; b=PTLrAue0qCy0bZWl80NPCPkuaT3PK5IDKLH6R6wWkWBtShm8Ns7hUX1f/RbdMGUwNm9PwpAd5qESibyxOMl7lW914GnNamJmnlKLcXv6KuWyVf69TkbYWMljTau7fzLYLnDzfrbv/eqYmaoS9po/hICNcecyf6kC9X/fndBMGdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734361155; c=relaxed/simple;
	bh=CnvCaWfgDwIgWkQpCmUclLH+JSJGlMt1flV6kcuDogg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aae3712Kos+/vDftVvDqUqgoy5q4Qy1+SeBZ2y9+wA03sJShX++w9/8EbtnAtlnM1l98qpX+y9IeVhXWlLNvPvzABJgMno/Hkm4Z01ZfHhkZhhQ3vNApFIZTSbn9um4Lgbi+Uh4T45Y/MWm4ITZoyqlYzAOXeDZWZ6OoRpAOq1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpUw+ffu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194C5C4CED0;
	Mon, 16 Dec 2024 14:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734361154;
	bh=CnvCaWfgDwIgWkQpCmUclLH+JSJGlMt1flV6kcuDogg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tpUw+ffutRGge33RcZNfYtcrP4tvXIGpc2EocSBMRUa3L0AKfWgSvhR4xUJuAjG2L
	 JYuVLSdn4gSFYNJ+hVPasm9euCexo1DmxJet8DCJEn7/FboftWcrwgogu5WsUBwmP7
	 UmG3dh8jisxi6QzFn/u9yS8pYU6MAVpw0wpeNW615w175U8G3dQYEgztV8KASfe1QH
	 aM5eDBV7FtIOk5Nq8zZv50Ye+NJAvVaJ5l0y2UjbCmFjwAuYqu04x9Ay8J41ZKE1/A
	 fye1EBBDzjFEVlXLnuAUc5MQ4mADgp4Ug7mr8K+I0UjoLsviGbBY630gMhoaLeG2+/
	 zKZ448pI4jznQ==
Date: Mon, 16 Dec 2024 09:59:12 -0500
From: Sasha Levin <sashal@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] arm64 fixes for 6.13-rc3
Message-ID: <Z2BAQEuXJg01qWDp@lappy>
References: <Z1xx0ha7lbKkdhRC@arm.com>
 <Z18MixiGByAqDYLC@lappy>
 <Z1_6ukG_Lc5leG1o@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z1_6ukG_Lc5leG1o@J2N7QTR9R3>

On Mon, Dec 16, 2024 at 10:02:34AM +0000, Mark Rutland wrote:
>On Sun, Dec 15, 2024 at 12:06:19PM -0500, Sasha Levin wrote:
>> On Fri, Dec 13, 2024 at 05:41:38PM +0000, Catalin Marinas wrote:
>> > - arm64 stacktrace: address some fallout from the recent changes to
>> >  unwinding across exception boundaries
>>
>> Hi Catalin, Mark,
>>
>> It seems that kselftests can hit a warning that was addressed in the
>> commit above:
>
>I assume you're referring to commit:
>
>  32ed1205682ec42a ("arm64: stacktrace: Skip reporting LR at exception boundaries")
>
>... ?

I was actually thinking 65ac33bed8b9 ("arm64: stacktrace: Don't WARN
when unwinding other tasks"), sorry for the confusion

>That was intended to fix this specific issue, as explained in the commit
>message (with a very similar splat from running the ftrace kselftests).
>
>Am I missing something? i.e. are you saying it *doesn't* fix that?

Right - LKFT is able to trigger the warning I copied on Linus's tree.

-- 
Thanks,
Sasha

