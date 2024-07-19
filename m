Return-Path: <linux-kernel+bounces-257644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E1C937CF5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 21:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AD2F2827D4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 19:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47831487D6;
	Fri, 19 Jul 2024 19:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jMnqP5b7"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD0D146D49;
	Fri, 19 Jul 2024 19:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721417249; cv=none; b=P26PMFxldd2aegcq1mbeJ5eTt6nw1G+QNwvqtL1IBgLaTiM79eZG4H1PcLYBwhEllWWTeJ7WfCIAv5yR692qQKo9E+St44g33oSy4Zwmpsrjy7Ee4gBDQpNpQLSLdMtbOsiOO5XyjIIkdsYdIIY8nmUkDq+6dnqtuySJN3IWAk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721417249; c=relaxed/simple;
	bh=xYsG16WrIP5O2lgGjunZ6hEDI+iT8N9gWTWllXnRowI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPV72w0ZfF/y5a4ihjQFdonO92maMw75RsdokVx+7KW/Wnbm2UEw2N0F4dbWPyDR2AFBc5IK82wGVRdcR1U7ByOlWSTTS2HJdDd4j+lESj0vaEtKci4PRG/BDlnzNI7tH2eO5FUSRivrzXt6TwTn3boXxpQM95bhFTKA36CNvps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jMnqP5b7; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WQfnl2WN8z9sRx;
	Fri, 19 Jul 2024 21:27:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721417243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dq0N8Y09218mTmvFklX6gEY2lUcoEvpqU2QroNsXU5w=;
	b=jMnqP5b7VpImKQA2w28h7MI4vo25P2XJaNuJZ5zRNwDz1JYW7f35zLOYHl8xkO1UPd3n0t
	oqHBBHcoSZEByz+DU/x67JiULi/Rwvxd+lSAc9E8fTQ81okWSXI5JaLvu5qtcXpAtIk6KL
	zd4qtvd6e0g1gKmJWeF/vPM6GhX7eAHAIA/UDcJh3q7VBZWNhzVZCLAQEucztIyOthCYFZ
	xqr2VhQ2SQ+MGETfm++GuHqxDIgUA52LuZ1uoacboX5tpcljIJuPh/pFWwfB6miO0IyGJk
	WLtLLVD6O1iNq5pWfUKkRznf5/84mNGa5PFRbf9jsM8pu7siYfi7at3gFdGStQ==
Message-ID: <56576cc5-7880-4914-a9b8-d021a239de3c@mailbox.org>
Date: Fri, 19 Jul 2024 12:27:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: My first patch: Implement InPlaceInit for Arc
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240717034801.262343-1-alexmantel93@mailbox.org>
 <CANiq72mwTq4m-u0QO2tdF5Z8++xnepgtG_dALwq7ar5JOkwuVg@mail.gmail.com>
Content-Language: en-US, de-DE
From: Alex Mantel <alexmantel93@mailbox.org>
In-Reply-To: <CANiq72mwTq4m-u0QO2tdF5Z8++xnepgtG_dALwq7ar5JOkwuVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 254032fcfb9365bfb46
X-MBO-RS-META: tzqwiuw494rppbbprk16sjon3y9j4sxn



On 17.07.24 01:52, Miguel Ojeda wrote:
> A few notes and nits:
> 
 > [...]
> 
> I hope that helps, thanks for the patch, and welcome!

Thanks, very kind! I applied your suggestions on a v2 patch:

https://lore.kernel.org/all/20240719192234.330341-1-alexmantel93@mailbox.org/

