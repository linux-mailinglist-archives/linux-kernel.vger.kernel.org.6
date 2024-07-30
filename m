Return-Path: <linux-kernel+bounces-267624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F214894138B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC07284397
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E721A0AFA;
	Tue, 30 Jul 2024 13:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GGmjtsVN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6571A08A6;
	Tue, 30 Jul 2024 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347320; cv=none; b=Wfvt0xsOJ6H1nYV/Movvp5cRGc0Et7vMt0iFKTdD1Tjnv0p5/NwlO0ZaYq2YHFkGZa5ivAev63kFjlSIf3Pl9rg5mxgmzDb7NuOSZ+DepVcf5ZiMRPS4NqIN3+Dr8UCmAe8FAZG1gMIzuG4FpV51GZadGOKPcRbrOhhQn3Q93x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347320; c=relaxed/simple;
	bh=19EPvewT3YzqbgajqYqH32Oh2Vdd5jdhhuXfeN4OrL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrE1iZ8sGWngGJoKvmISPiShSLQjWy27B0aG+PDm657buFxBGG/Wzh/sLhitO4Y3SZ1Dxzqqm95deVk5U+W3HHfA0Snt1fp+2ZK9AoLUHRdTRWy6eiPxTlitQb1XAHxx7Go21CTF+q2OCJiBt/3Cf3CS4mbv+5i7rNXusbi++Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GGmjtsVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED727C4AF0A;
	Tue, 30 Jul 2024 13:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722347319;
	bh=19EPvewT3YzqbgajqYqH32Oh2Vdd5jdhhuXfeN4OrL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GGmjtsVNuWG84+B2vZKH14pH5AigiM0ENBvf2stL1J3fo7RpaC/DMIcZF80+Sqme1
	 Frsuvy0dvUjdlqlf0FvVXXlXJtP8e82Ix/FcG6uFBPVlCMqrawQb/3ehRts+2bBgOK
	 RtNMt+RLuBC3LCViu7zZcJCXmL/X9jWED79xDfcU=
Date: Tue, 30 Jul 2024 15:48:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Erpeng Xu <xuerpeng@uniontech.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, hildawu@realtek.com,
	wangyuli@uniontech.com, jagan@edgeble.ai, marcel@holtmann.org,
	luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, guanwentao@uniontech.com,
	luiz.von.dentz@intel.com
Subject: Re: [PATCH 6.1 1/3] Bluetooth: Add device 13d3:3572 IMC Networks
 Bluetooth Radio
Message-ID: <2024073030-woof-afterlife-6bb4@gregkh>
References: <0FAB34DF3E2E47AB+20240729034247.16448-1-xuerpeng@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0FAB34DF3E2E47AB+20240729034247.16448-1-xuerpeng@uniontech.com>

On Mon, Jul 29, 2024 at 11:42:30AM +0800, Erpeng Xu wrote:
> From: Jagan Teki <jagan@edgeble.ai>
> 
> commit 9f503d62f6d3e4ed36f9f832b8b1b1eeb0cf27e8 upstream

Not a valid git id :(

