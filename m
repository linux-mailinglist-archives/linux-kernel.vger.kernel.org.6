Return-Path: <linux-kernel+bounces-558944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F58EA5ED66
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C4D17913A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4291525FA1A;
	Thu, 13 Mar 2025 07:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OeDWk/LT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dRU53w2u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2FDF9E6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741852543; cv=none; b=aWIgZaErl/+dh9/4Aq9KlvgME0SBfd37RmVaaLUFFOQEgSSwAjJAZrW0xBYXWrQlB83AetvXuieNfEtNXIhUpKsxgy9irLlsJul2o8UI98r7uGujaOzVqAO2js81bi7li6N9w3lz+cwPnLhwsip8nM1W0z7kaXVKiK2lhozZZfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741852543; c=relaxed/simple;
	bh=o13F7q7RQvbxTzix5u7hz522leiCwUWhw4VMqQG5wwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgpOB1NumjlkuPJyW9zIsdx4xiZLfAdLD7PjYeaGfaszyw8IrGciNFFj4VXdSnLXW8XRLQNrWjYOw3k/965ppqRWSBHSIs/BBRIiyah0vlUpzONJRkFTdsZztwU6gdJOcGDk4bj1oGG2XUaIPoY7rFSP8p+30XX8Uo9vPsI4GWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OeDWk/LT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dRU53w2u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 08:55:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741852539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a9Fvg7N8yjcDwbghNVTSm1qmeclhYy7BL90/Gxu+5nU=;
	b=OeDWk/LTuUbjcoBO6ydFLwxAo3DdJpIAug/yMrMSn9fvJ1R8tnhxHndya+C26WG1zQrZE7
	+dWxE/ks+5Lcxf8BA8iV8cVekuGVd+pZMfQkuYSP1i9hsKhvF3hECq8kWul1Ei1LfvKSqV
	U8JcBQ4RKyDe0uqN9yLF5V91xOXRTcWxRz1owh8u2B3k5DyWyotk0W7Uv5+a4FBwjE4fxj
	S8eF6W+943GlArwJDDYyP6CM3bUaLhoGeRQts3qQ21Xc3b3/Ii/0K/KQzJDmg4NDwCukve
	JxQsFMYzGCFt3r/Ti/RtbRieErRm/lL0ap84tc9uqbG1ToMuM+Kjdt/sVTiUhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741852539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a9Fvg7N8yjcDwbghNVTSm1qmeclhYy7BL90/Gxu+5nU=;
	b=dRU53w2ubyKzQ03QAMgnIRiu0Fi9G4lVwcxblnU/71FPHF9W9DUzcl6rDC5lmegrB5m8Dk
	ur/q2sEWuy6fJgBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v10 01/21] rcuref: Provide rcuref_is_dead().
Message-ID: <20250313075537.NxNhKauR@linutronix.de>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
 <20250312151634.2183278-2-bigeasy@linutronix.de>
 <20250313042311.GA1395318@joelnvbox>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250313042311.GA1395318@joelnvbox>

On 2025-03-13 00:23:11 [-0400], Joel Fernandes wrote:
> This makes sense to me, another way I guess to determine if it is dead is
> actually to do a get() and see if it fails? Though that would be more
> expensive and silly.

good :)

> FWIW for this patch,
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> 
> thanks,
> 
>  - Joel

Sebastian

