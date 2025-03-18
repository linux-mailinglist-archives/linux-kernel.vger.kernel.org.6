Return-Path: <linux-kernel+bounces-566497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBA3A678C7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD5C18873D9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3207C210192;
	Tue, 18 Mar 2025 16:12:37 +0000 (UTC)
Received: from serval.cherry.relay.mailchannels.net (serval.cherry.relay.mailchannels.net [23.83.223.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF99620F092
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314356; cv=pass; b=LYJeM0IEsGMV3I3UH1CUwR0tcPbmw6hzfcYFlkVwBiAWydiQom8wZDQSak39UgYFA4lnVQRMj4nRAxyluVRRwJe7e8R+vZeRtGDxShpYkmfkmoqlA3skLhocd1Ezu+nQszEEvOXnYKzyVxfSFQ4XPgXvhB3cSmx/vDQmJjJGKjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314356; c=relaxed/simple;
	bh=gn/cOe/Ch76H6ZWDSqpCyU1Ou23RQUV5TKGwnBq8I9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZegMAKjWyi8yvdZstw17tE3hHld0+uRWOFpxX+/F9bvlgFOIeqklBCvuR8dLt5Gzog0OMG6X5GikwLTUptAbO61QdxuX/haiD7LJkktNIMQl+lfwYCeavz3geBdcOgEesiqM/wDhQ5PtOhl72VLKQoaFSnbp/+6nlK7zUFcNqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; arc=pass smtp.client-ip=23.83.223.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2E3C88A4C8E;
	Tue, 18 Mar 2025 16:12:34 +0000 (UTC)
Received: from pdx1-sub0-mail-a272.dreamhost.com (trex-2.trex.outbound.svc.cluster.local [100.125.202.153])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id B461F8A473D;
	Tue, 18 Mar 2025 16:12:33 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1742314353; a=rsa-sha256;
	cv=none;
	b=J7vxq/mZFSnp8HtHpdYmHUOgLWAeJFleQ5glftWyEm5a5d/hryJLnrrwoPMlcg106iGQ0O
	lsHWkui30c6gZ3IHGc7YRNzHT+eKs5BdQnwDXEl2/eKwj2JxbvRg63tGh9xI9OCM3JoP/X
	/g6+XGGa6zu1VQILdaAm3xsgx4BKmMdyZzDQDrg84L+pevXy5ZbUPWvUaJhTSWJBETHoNi
	DBbR9wgWMKZJMNwJH0KWE2gtaSKXKTH4erWEhppbyaViaVgT5Vwh2QrEwlNXZuRFN1tbc4
	2sWXE+3Pm9PzVJtf1sVONO9e12va5XjA3WHF7Nyr2/IDkyAyZ5PUzhIof8szGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1742314353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gn/cOe/Ch76H6ZWDSqpCyU1Ou23RQUV5TKGwnBq8I9s=;
	b=lLD/lgh+vIbtP/JVaPSIcWC3l/ddsqQqC48kiVWd6pgeYf9mYE3fuTyhQ+Jz9CgBYLNofH
	9JNO1bb4Ubw9fGCUrPxX4oOhUZ/4yYTVi82z7cW/A0R3VpGRf95MX6FZieGicCMIEGAcE7
	BO3eUA5h9uKBDXGj+XzSp7ID9QYycY/RHbQFRdcOg5OhZWJQz7mzFNXZVv71eMWxTvykTW
	7sC9cuvfYmTSOED14ITR1t09SBU9gwmFFgCUENyVwq6W1gm+sTjPN8ugfL1QhN6H9XdIw7
	Qc/FLU+fjPGkyHXFBJQ5fjWmZMSv0VKqCOTqVMI5MCB70Kq0aheJ1VM6+v4psA==
ARC-Authentication-Results: i=1;
	rspamd-5bd7b8dc7d-d758z;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Stop-Quick: 2e39202d42fe9e5f_1742314354029_1210016668
X-MC-Loop-Signature: 1742314354029:3274079141
X-MC-Ingress-Time: 1742314354029
Received: from pdx1-sub0-mail-a272.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.125.202.153 (trex/7.0.2);
	Tue, 18 Mar 2025 16:12:34 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a272.dreamhost.com (Postfix) with ESMTPSA id 4ZHH1D61jPzCZ;
	Tue, 18 Mar 2025 09:12:32 -0700 (PDT)
Date: Tue, 18 Mar 2025 09:12:29 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	=?utf-8?B?QW5kcsOvwr/CvQ==?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 00/21] futex: Add support task local hash maps,
 FUTEX2_NUMA and FUTEX2_MPOL
Message-ID: <20250318161229.i6mfbsxrw7ordiyq@offworld>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
 <0713a015-b8dc-49db-a329-30891a10378c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0713a015-b8dc-49db-a329-30891a10378c@linux.ibm.com>
User-Agent: NeoMutt/20220429

On Tue, 18 Mar 2025, Shrikanth Hegde wrote:

>Also, is there a benchmark that could be run to evaluate FUTEX2_NUMA, I would like to
>try it on multi-NUMA system to see the benefit.

It would be good to integrate futex2 into 'perf bench futex'.

