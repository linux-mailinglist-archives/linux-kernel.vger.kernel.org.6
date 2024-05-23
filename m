Return-Path: <linux-kernel+bounces-187003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA6A8CCBC0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32BF81C215D2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 05:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D4D12B16A;
	Thu, 23 May 2024 05:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="NCJ70/PC"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCF31C36;
	Thu, 23 May 2024 05:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716441628; cv=none; b=PlDf3U2uUaRsGnSoqj0CHQWa5TVn1ui+DaS+atPPOgcNf3FUTcq6yetYAwFSCZAWaly+39QhDa0yCImgarPhq76VSYikPvzedokAdPFjQqF50jO7IaAAl4Yq5G3RcFDfXyc8ZGw7WynlbNriDKXe2xbVcaAhwq1L/z9fq0sYhwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716441628; c=relaxed/simple;
	bh=PeC5iXfkIeU7spJ0VmixJQ2YQzDdAfaxUA9JmeGKvcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/s5ZxpAY/skwL09SXkdewetpksSBPgEsA7XiHGJYUtVPEW+C80uBKFZdRBeCcSUSy1Ygo7fBl//1pDmLXGgm2oGdFFtJkcY9ylSOIRYy//fYuMClb/aM2UlWi+FBd85U9kQ1iWLsj+aMn7HU3Mqpu030SS9tOkwGZoQNeKctog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=NCJ70/PC; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=fUzokhKC9+TC+7P2/H37759pRNlpzZPwjqYlpOyCjhY=;
	t=1716441626; x=1716873626; b=NCJ70/PCqhMvsPcvPOYo9Yl58CK1VG8pMBrXynDTGFn3S43
	3mql3nVSc4Zmi2s+hScCzATf12RtHHaCfV3bIpb1sEcBrLmhvUKSIEax1hwYXE+TwgwhSGkYo9CO6
	SzeFS33LQ9G/QdRYrLZ9Li6qcs12HRIOKyeDuchDlQ7EN1KVB8X2mEJaSUi/rXMJWEUAo+go7bEYi
	ESMBY54Vv4p/inGgxW3Ms/1VsydzoDOptbEqjuJ5aaOIelw0+1jHd6GDh4WRGxuaRKfBDzZ1Rl05z
	4tS9J5gl3O4BiCP+XFNPQRzAjKOIZSSTDT2Ai/x08TfYrNuNyG7PBqWAsbRtjhsQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sA0sJ-0000YB-5m; Thu, 23 May 2024 07:20:23 +0200
Message-ID: <b0c932ce-1a63-44ee-bd0e-e93e6e164d20@leemhuis.info>
Date: Thu, 23 May 2024 07:20:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Early boot regression from f0551af0213 ("x86/topology: Ignore
 non-present APIC IDs in a present package")
To: Thomas Gleixner <tglx@linutronix.de>, Lyude Paul <lyude@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>, Borislav Petkov
 <bp@alien8.de>, Linux kernel regressions list <regressions@lists.linux.dev>
References: <3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com>
 <fd040809d95b3e12b2fdc78a2409e187716bc66f.camel@redhat.com>
 <87plumxz4x.ffs@tglx>
 <abbb7d7ca781f6c664e4c5b1dffc19394ac79691.camel@redhat.com>
 <87le59vw1y.ffs@tglx>
 <3a0afe545747e5314a9cb6bbaa9ce90b259ddfac.camel@redhat.com>
 <87edautcmz.ffs@tglx>
 <3b1d16e357c1f9badeef405366492f05af26c085.camel@redhat.com>
 <878r11t8zu.ffs@tglx> <016902d9-3858-4c65-b3ec-f7a5103af63c@amd.com>
 <51d0dff8-2888-463c-95ab-71b491f12a8f@leemhuis.info> <877cg4ppd5.ffs@tglx>
 <ea927dad269cc21de1d0baf3d6c9f66ee025b862.camel@redhat.com>
 <d2c6f335a6eb5892b0d894d5df4a6e713fa013b5.camel@redhat.com>
 <87jzjxn6s5.ffs@tglx>
 <d3fe5278e7cd5af6c62b470b281b547b67e3959a.camel@redhat.com>
 <97bd95480a8b9951edc9ee2d2648d1b9c574e3b0.camel@redhat.com>
 <87bk58n6le.ffs@tglx>
 <2fd6009d21d606d13f0c472dbaa754a21f3105d9.camel@redhat.com>
 <87wmntkhak.ffs@tglx>
 <d4496b4ed8a8a7bb34cf12e4cce65a6ad6705bc0.camel@redhat.com>
 <874japh4ww.ffs@tglx>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <874japh4ww.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1716441626;970a6ef0;
X-HE-SMSGID: 1sA0sJ-0000YB-5m

On 23.05.24 00:12, Thomas Gleixner wrote:
> On Wed, May 22 2024 at 15:35, Lyude Paul wrote:
>
>> Awesome! This patch does seem to make the system boot, thank you for
>> your help

+1

> The only thing what's awesome here is that it confirms my analysis of
> the underlying problem. I offered Borislav a bet on that, but he
> politely declined :(
> 
> The not so awesome part is the question what to do with that insight.
> 
> The first issue is that we don't know whether that's only a problem on
> your particular system or if there is an underlying systematic problem
> on that particular CPU variant (model/stepping).

FWIW, Arch Linux and openSUSE Tumbleweed switched to 6.9.1 in the past
few days (Fedora will likely follow in ~two weeks) and I have not yet
seen any reports about problems like this, which is a first small
indicator that this might be a system specific problem; if any such
reports come up I'll mention it here.

Ciao, Thorsten

