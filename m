Return-Path: <linux-kernel+bounces-534110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C01A462E3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9337189D70C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BD9221713;
	Wed, 26 Feb 2025 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oj8IU1jG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dVTJE0Dq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E5521D3FE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580344; cv=none; b=eTsLvR3A/lDQ3w7cxcsA8RTmiGmNg6oGPRtRMLvLAXDlJOYRub0wmaS5X2o8im0O+HSKdiBDKzf0FWC2POXuNp/0rkcmk7OcW2tSQYAZPn0syYyQnmDiJcilJ5OCMB+PnHsFaAr6bcWn+HaCgS6nrANcFdohboCJjjYP3IjOvGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580344; c=relaxed/simple;
	bh=/Lv5dLzEHvMto0dqDZ+4akFVh1B4xomspGePhh7mwt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRrJsZbAkwyM8c0EKS+6e89yDdoiPkrLHEyd4Rd7fo4t/FfywKPO+g/j0bUyhpmUATQAuvsz27wbZQMVoDZ9jQPuP4EztLG1dbL2VZiyTIyurx+iDTdsFCY5BMiw1WXhE8WqDj90gRciO1cWbEAQlPSG3zULLbvr5a0dx6z3//o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oj8IU1jG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dVTJE0Dq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 15:32:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740580340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Lv5dLzEHvMto0dqDZ+4akFVh1B4xomspGePhh7mwt4=;
	b=oj8IU1jGNvV2C/uIb6rFbWn0QnvNVJcjpKkk8l66AvRnxnclU+fWIsA6dh1M20wnPxpC4m
	fuF2TGTgdSlGiCr/Gt6r55Mnmdz3dBSOk6A2bBm3PNweBE0pGRoHsixYwsZ2zKy+YfvglN
	aECRlCC11qF2rk0ukzR2K5m0udrTTanowaTNQkYoAjed99pB2OQbUf+11jDe6DOkn/dxQY
	g3bchQ9RgVoAyRNwsWBw30OLVk0FrM0oJsq1NR1oFajcjPPZEouYxkogTk0nQYuru/rQhp
	hMfgx7EX4/oPwtnGP62PxdUKBW7+dyunZsVomiXhW/RS1abaG34EEivtacF7/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740580340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Lv5dLzEHvMto0dqDZ+4akFVh1B4xomspGePhh7mwt4=;
	b=dVTJE0DqzqbiCRCo6xuSpYe81pF1v0NpcyOqruLZsqPG7osV+y0D7ibh/Cn46JscTw4ygJ
	aALI6qV5hU/iPHCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] task_work: Consume only item at a time while invoking
 the callbacks.
Message-ID: <20250226143219.-T7dpcmy@linutronix.de>
References: <20250221170530.L3yMvO0i@linutronix.de>
 <20250223224014.GC23282@redhat.com>
 <20250226141601.VBQ91ZDb@linutronix.de>
 <20250226142914.GF8995@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250226142914.GF8995@redhat.com>

On 2025-02-26 15:29:15 [+0100], Oleg Nesterov wrote:
>=20
> Not really, they can run in any order, so fifo can't really help.
>=20
> But this doesn't matter, please see another email:
> https://lore.kernel.org/all/20250226125048.GC8995@redhat.com/

Yes, I just got to it. So it looks like that wait part from task_work
should go=E2=80=A6 Let me check Frederic's patch in this thread=E2=80=A6

> Oleg.

Sebastian

