Return-Path: <linux-kernel+bounces-381453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A35F9AFF71
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05311B24E78
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9181D967F;
	Fri, 25 Oct 2024 10:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KUtg/VWk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BvVK7662"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979731D1F7B
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850622; cv=none; b=dc/3QyaSDpKffApZbXGHTgcx2NjL9AB4qtFkYU+GPoWGS/F8nwkkBd5/TN1VesjyaDSHUpkNaA9sJIXX8h8hu2Al+5q5/wcwhMGdUgRTaLXKyb9IETcawCOKbI+DZ0iH+OqV0qM9hPgJ00rUSiVikAut7gwtWJwx1kj+4g3LBjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850622; c=relaxed/simple;
	bh=4+vxGsmysunGnnkYtxuUqQYhqM5WPXzjRHuVc3vPOcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wwj9kUnu1zHDk6nKH9uvoMLzSZXdLWNC4EAUv+Dc8cEnAlrPX4XHlGOXD0hEd/m0iz7wWqw7VWDiSf1LKPSM487USGKRsmgTAcn9g6SNcAWe0iOA06dHTVPs8D9Us5K7oTpxsanaNthMRCVpVepqOPIiFyHiEcfyEb+zV1eU5GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KUtg/VWk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BvVK7662; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 12:03:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729850618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kXnLbWg/pSVZEV+IncuH+B91U7YDz+CkkQf4woAq2oc=;
	b=KUtg/VWksfxTKNYEfbebvQq9LHsbSxBlgZTqlEttnmEZGDXPoGvPjI4BsoGaaJRq4W8H7N
	Z8qSUrTa9pfLYQ99G12OkMM6d0Qa4Sbjlgm+XxG3ESp55CREK3/Ua9e8CiEwtzjPEPkgOU
	i9+e3Bja3UJyKhY0JkL0M0kGMWAEaab660knJUTqIJF8ljTn2wnMlce/KgQhD+9zMMdgQ4
	WzWcXMwwy7aZFEhKvJ5FYNk1+eslTBUjoC+yYDP+UE5PTLP7inIiMT9reRRK3kCDHewqjx
	QH+Ig/zBuJslNP/D48fb1V9ppl66EoMDesLXo5SDtcBkMSSmxxZRRtuEJGuWHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729850618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kXnLbWg/pSVZEV+IncuH+B91U7YDz+CkkQf4woAq2oc=;
	b=BvVK7662tRG0VOyCtbqk+pt5DehBLwAy9i5Gdl4zat6sGEhphwnxoImTKFlm1EYnUYkCS8
	obmmUC3kwqlT3kBg==
From: Sebastian Siewior <bigeasy@linutronix.de>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, oe-kbuild-all@lists.linux.dev,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] sched/uclamp: Fix unnused variable warning
Message-ID: <20241025100335.urH9-GLU@linutronix.de>
References: <b2ad1f31-21b9-42a5-a735-b9496470348a@arm.com>
 <087769c7-f8e7-4701-b6f1-4585570b8be8@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <087769c7-f8e7-4701-b6f1-4585570b8be8@arm.com>

On 2024-10-25 11:01:08 [+0100], Christian Loehle wrote:
> Gentle ping and adding CCs

Thank you.

I poked Christian since the bot send another report
	202410250459.EJe6PJI5-lkp@intel.com

Sebastian

