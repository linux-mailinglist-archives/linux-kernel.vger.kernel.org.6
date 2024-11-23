Return-Path: <linux-kernel+bounces-419170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE599D6A40
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 17:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55B051617F1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 16:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B6F137932;
	Sat, 23 Nov 2024 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tinNKVoi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FEA17C2
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 16:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732380130; cv=none; b=L/P7jpTj0WpMPZZ4Yi1zjwmDUvrn1wd1W6rlHFW/PrPn5cSGHGUr2dPXfFxdSGNUBcmv6pQ/ThweyFfnwImddaCxgtvarrWA2WfkTY7On9jIHgko8YQVszHHZzDGotTqA3VLYZG0f58wONR9k97W4ET8LQCViDliWGEizB1YN7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732380130; c=relaxed/simple;
	bh=4Q2+RSLkXzG2kgg54Hk7esu7FK2usFXCNqkK2w1AudM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFig3/KnjhDr7d4LKz62qzS4+PnM8PuB9Jxoxhvva7bcq39ExcU6ij1lPEVNDCCRX+n0z7bTPvTH75icq6bpBHGhKm+oL232FP4zdxcYa7px6OvQGWAo1ZlHtt3394yjowUj2DtnnU66ZUlCTa0ZfJAlHWXkNFj11ZyFInhkvJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tinNKVoi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEB0C4CECD;
	Sat, 23 Nov 2024 16:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732380130;
	bh=4Q2+RSLkXzG2kgg54Hk7esu7FK2usFXCNqkK2w1AudM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tinNKVoi+EbrN8EwkgNNsCWIMP91u1suXzhQJp7uFRJc6OKUgoiWa+N7sxc44x2b0
	 d4YVxBJifHAr+sMYWpjEOqRGwmcxyxO8QussQmnlCa7m2/HNmnzDTtjDer1YbZYO66
	 weEmEDTcoWn2P1bShNZKEL6PVnPSTbX3fisj+988ixHprkNZ0dtcW1SoPyu5T/uqwJ
	 7F4CrfFuJA3fIslcnDvt3v3ISzkVhg++YoCf8vaRKOZ+fTMmZoCeXf6CSX4lCVw3q+
	 HQ0y4jtcTn3OoRk1Fp+xoI+k6rC3YRiTRspBiHEneDy8qG+ErqgCkETzx5DuJQONeT
	 1nWJRz75OJKng==
Date: Sat, 23 Nov 2024 17:42:06 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] HID for 6.13
Message-ID: <ziofbee4q5cvxvovpzb2rfjw2cduefpm4umwtfyyx5kfwajjp4@nrjwkqryz2j5>
References: <nycvar.YFH.7.76.2411182207390.20286@cbobk.fhfr.pm>
 <CAHk-=wiUkQM3uheit2cNM0Y0OOY5qqspJgC8LkmOkJ2p2LDxcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiUkQM3uheit2cNM0Y0OOY5qqspJgC8LkmOkJ2p2LDxcw@mail.gmail.com>

On Nov 22 2024, Linus Torvalds wrote:
> On Mon, 18 Nov 2024 at 13:16, Jiri Kosina <jikos@kernel.org> wrote:
> >
> > please pull from
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024111801
> >
> > to receive HID subsystem queue for 6.13 merge window.
> 
> Hmm. There's something odd going on here. My mouse scroll-wheel
> stopped working (Logitech MX Anywhere 3), and this pull would look
> like the prime suspect.
> 
> The mouse otherwise works, so it's not that the mouse isn't found,
> it's literally just the scroll-wheel functionality that doesn't work.
> 
> Oddly enough, if I remove and re-insert the Logitech wireless dongle,
> the scroll wheel works again. So it's not some kind of complete
> breakage - but it also wasn't a one-time fluke thing, in that it
> happened twice in a row when rebooting into a new kernel.
> 
> Any ideas? Does this make anybody go "Hmm, maybe ..."
> 

IMO the suspect might be 526748b925185e95f1415900ee13c2469d4b64cc.

My idea is that if you reboot without completely stopping the pc the
mouse stays connected in the "high res" wheel mode which hid-multitouch
can not handle. However I don't think the bolt receiver is supported in
either hid-logitech-dj.ko nor hid-logitech-hidpp.ko.

In addition to Jiri's requests, could you also post the dmesg after the
fresh (and broken) reboot, and after unplug/replug the dongle? We would
get more information on to which kernel modules are involved this way.

Cheers,
Benjamin

