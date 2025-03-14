Return-Path: <linux-kernel+bounces-561496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9717AA612A8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A7A3AF93E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABF11A5B87;
	Fri, 14 Mar 2025 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BZa9Wj3w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RL82pk/h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603FBC2C6
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741959043; cv=none; b=M3UoiDTjnpk/GMevMxJ2BTLRah98lCN5yAFd1aGRPRTXE08wl8M3x4d21Y1sDhCaooPNQ9fFePFdbteW/1AnklorDr6Ijy+IW5bgj+J3tGvqdu7lwpUaTaVIkIgcFIzX6+FYnTE5TgQyYKVBIfKVQWnwiCVJDGAB11RlfwOWw/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741959043; c=relaxed/simple;
	bh=PoZkHOWVA3pj2hoW/Ga3qJPBJ42cLzuUlRVqwtswjhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efwoLZOpawZLC+0EyGZ7RMPsF34WSw5cEoIQzCUMr4qMzVVCJG8OY1vpFfw7yJGLxjnpWkHVLyzb4kux6MDzo0me454U3gyFdunt1JelYDsWXm9GzMT1voT2pN/qmcVzsl4xQuRSRaCQkHLPNBTDP6QLyF8y0oHYF/gkBlrMHe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BZa9Wj3w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RL82pk/h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 14:30:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741959040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6zrsZx9dzcC/hKFpnqik0KP6zc1r2uYMfmMqOv6gtfE=;
	b=BZa9Wj3wfB00AcsnhFX3Myy+NKRAb9i9qOujXwm028vQ3EzvAe10gyyL5BDlqzB118jSo7
	KXhTZ2Z/gITfbkXyZoPaY/UI2V1GO+zuruMppk/+7xYCorO8RgNIw5MkN9koPfbTPntJsb
	fKnqc1Cb8kDhHPEvLrkSQB5AfVcAvJEnOiwAfLn+QOc0jM6+kX41TBv+StG+3Xql3nkRxB
	WP5CmjtX5sJGwl3YunMMtaJzxce2fEkKpnGtEUzYHIt4UUfGi0p6x5NK6O36ia61kVQMpS
	aQpPrFjCrxCb378nnfFX0gbSNPD+wmA9bVm/RGKzw+vszydITiK4Hdnbj4/ppg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741959040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6zrsZx9dzcC/hKFpnqik0KP6zc1r2uYMfmMqOv6gtfE=;
	b=RL82pk/hgcWTrkD1JZXLqtba2ylreI7a/3dWEkUlz0pXQ5Uyox2LSPNLUxeC8HEXp7O5Dn
	EMqfG6zZrkMlDiDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH v10 00/21] futex: Add support task local hash maps,
 FUTEX2_NUMA and FUTEX2_MPOL
Message-ID: <20250314133039.GYPBdpep@linutronix.de>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
 <20250312151848.RlB_XuHA@linutronix.de>
 <20250314105856.GB36322@noisy.programming.kicks-ass.net>
 <20250314112808.-XVssA31@linutronix.de>
 <20250314114102.GY5880@noisy.programming.kicks-ass.net>
 <20250314120057.NcjcFp3K@linutronix.de>
 <20250314123058.GZ5880@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250314123058.GZ5880@noisy.programming.kicks-ass.net>

On 2025-03-14 13:30:58 [+0100], Peter Zijlstra wrote:
> > > Yeah, but sparse is stupid.
> > 
> > I though we like sparse.
> 
> I always ignore it, too much noise.

What do you suggest? Cleaning up that noise that noise or moving that
RCU checking towards other tooling which is restricted to RCU only?
Knowing you, you have already a plan in your cupboard but not the time :)

Sebastian

