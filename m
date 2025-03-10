Return-Path: <linux-kernel+bounces-554927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9289BA5A377
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151FC3ACBBD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3AD234969;
	Mon, 10 Mar 2025 18:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlpeKZg2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7659B17A2E8
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741632932; cv=none; b=YqePAq1rsFc00N/gISu1t2KnQxT65DkiFPfQec+k4yaGovxFDKTX6oWfvrjw0ATTYUEVXwOnIHOTQUkOGiZ4sAPkN400IjEgE4uvAmmyWZoEPJv2SWUAimvcaixA2iIYo0iyqWRsqZtWHVJMp/lJOBOzcxS1NnIPczWrKFdBL34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741632932; c=relaxed/simple;
	bh=YeEiCX3eO6SfdtFU1Q1WpSRmJDm9wzrGwehlgBcf3og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMbWSxJK41QvlewbZCA6xFZUodUBL9Vm9EO2JfjRufax/9hq3O3Qejc29ZF9a5cWC+PIqocGuI8ZAK3AyQKwJwP3rnZczB/p4OJlTmbVUWhCXuIGdztPXO8v8C0mc1iMGTCeSP3v8WNQvxwojonppXGFj8njIqD5nxt23Tn4Ni4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlpeKZg2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF259C4CEE5;
	Mon, 10 Mar 2025 18:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741632931;
	bh=YeEiCX3eO6SfdtFU1Q1WpSRmJDm9wzrGwehlgBcf3og=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mlpeKZg2OZddd//uz0p3x4t5A9gqRDKwR/xzMOhK54jJ7x7z8oIQPNgZaNgMYXLBs
	 VbPP7c0QIjxQuuR+lrF7jjdTvt6IYtL7MmJ7WZWmBVZzzLH5DxOJK+CndUG1BD2CVN
	 n8ZQZu591P+bGrq4Aep6sWt/me+CFQ47AadUMb38N3TSmvVLbJsTpkcEA0LDd6Ixso
	 wMBt1o3Hoaa3+klzhYAqklRf9u3GN8ZGmxUs1vLOOntkpn8cd0Eq7rfMhto/jztaAM
	 vD//Y+luX1FZfmJon/uNQ640YMs1USJtnoMxFB8c97Xq2zXHFaOZi+A+aD/kyk8OcH
	 iRq3vOf/F4CuQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 58635CE079A; Mon, 10 Mar 2025 11:55:31 -0700 (PDT)
Date: Mon, 10 Mar 2025 11:55:31 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] nolibc changes for v6.15
Message-ID: <c9537841-b4b1-4dfa-b673-7a2d46755a89@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <25e1c397-d554-4334-b344-56ec252564c1@t-8ch.de>
 <00c760a8-0075-486f-9456-63ae07ecb341@paulmck-laptop>
 <3598f2c8-e04a-4e4a-ae1f-db2201fff802@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3598f2c8-e04a-4e4a-ae1f-db2201fff802@t-8ch.de>

On Mon, Mar 10, 2025 at 07:22:35PM +0100, Thomas Weißschuh wrote:
> On 2025-03-10 10:09:49-0700, Paul E. McKenney wrote:
> > On Sat, Mar 08, 2025 at 02:06:21PM +0100, Thomas Weißschuh wrote:
> > > The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:
> > > 
> > >   Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git tags/nolibc-20250308-for-6.15-1
> > > 
> > > for you to fetch changes up to bceb73904c855c78402dca94c82915f078f259dd:
> > > 
> > >   tools/nolibc: don't use asm/ UAPI headers (2025-03-08 13:18:27 +0100)
> > 
> > Thank you, I have pulled this in and will expose it to -next testing.
> 
> Thanks!
> 
> > Results from "make run":
> > 
> > 198 test(s): 198 passed,   0 skipped,   0 failed => status: success
> > 
> > Results from "make user":
> > 
> > 198 test(s): 196 passed,   2 skipped,   0 failed => status: warning
> > 
> > I don't understand the "warning" given that the "run.out" file has all
> > "OK" aside from the two "SKIPPED" tests.  Or maybe I am just forgetting
> > how this works.  ;-)
> 
> A skipped test will mark the whole run as "warning".

Ah, never mind, me being forgetful!

							Thanx, Paul

> Maybe we'll adopt the kselftest harness at some point and align with the
> rest of the selftests.
> 
> <snip>
> 
> 
> Thomas

