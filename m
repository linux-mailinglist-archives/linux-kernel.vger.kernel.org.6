Return-Path: <linux-kernel+bounces-528470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E08D2A41805
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82AE171FCF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B365A13D279;
	Mon, 24 Feb 2025 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XIe78IyU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uhrr5LYO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B967EEEB5
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740387719; cv=none; b=eGYySxqxyTFXUDar6HNDt05WztOEyEHjHJmrNR14+E7JmMa7Dm1WI2VlonjJamteNOUeSg0Yc6ioxjxz5FiZ5OstYI0CWdix+hN790fMvfL2/MAoTOxUqaVX9Y96KFfMojT4KsoT4tBpERaUM0uMqb12+5jN3S/IO8R3bHhpuY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740387719; c=relaxed/simple;
	bh=1FzywqgCKgWMkGI+DV99J4CScxgQoGC7Ld383gBGf80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8m7fIFHH4rlh4q1E0dLU3KgS3cCldS5T/iJIGQDjXG9TfZU0JH63lgOByZ3kBQZxX8GUYvgkoZP0OPUo8e4gIeDKV+8r+mpc4f7K7n7/a8Y4cxWofHY6VSKXWmuXiUfrpwe0ITNYM7Qa+42tkZrQAsS0qFgyFSzQRcRhSdSPHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XIe78IyU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Uhrr5LYO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Feb 2025 10:01:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740387716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=89B3J6ltof4hVeOt1caD0GAKTbuQQP4dUY3CeP0KuwU=;
	b=XIe78IyU2aFFnmeJDGLu6WIXJ5r2oE8fwMyTaKbRjlVgWpdBKTLpZpwJhWx0eoRxVY10Eq
	MMd0gIn1g5Rd9iu5Q78ZnChbF7sHYDAWEOLq2j06YZzYu1f3HFK8Z1rs5HlxKB/HVi6fsr
	MNKRlaLwHQrBl7AUCOq/Sd/LTtqsqCqkNl5NtC2oW8R3DjizGyH4rerRd9FBD3JHA/LrcV
	oeDvdcBkv1dWWbLOHB2GoEAiWaqimo4p62niuMByDKSumZ86eCMCAfnEnB59PmfB9sCUjH
	QEqVQGNrZ8OWw0bsLRwQZDMWZKOJHHYnn4FoYOrXl9aaCaa60BwarJantvyJdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740387716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=89B3J6ltof4hVeOt1caD0GAKTbuQQP4dUY3CeP0KuwU=;
	b=Uhrr5LYOyOo5kUw0+/7TIs0fz5/SnS7EAL046FItvyirjNDCmUFcNZwijzaiHyCL/qHh9h
	VgN5mQ2vwxis5sBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>, Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 12/17] zsmalloc: introduce new object mapping API
Message-ID: <20250224090154.7Xlsipmu@linutronix.de>
References: <20250221222958.2225035-1-senozhatsky@chromium.org>
 <20250221222958.2225035-13-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250221222958.2225035-13-senozhatsky@chromium.org>

On 2025-02-22 07:25:43 [+0900], Sergey Senozhatsky wrote:
> index 03710d71d022..1288a4120855 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -1377,6 +1377,135 @@ void zs_unmap_object(struct zs_pool *pool, unsign=
ed long handle)
>  }
>  EXPORT_SYMBOL_GPL(zs_unmap_object);
> =20
> +void *zs_obj_read_begin(struct zs_pool *pool, unsigned long handle,
> +			void *local_copy)
> +{
> +	struct zspage *zspage;
> +	struct zpdesc *zpdesc;
> +	unsigned long obj, off;
> +	unsigned int obj_idx;
> +	struct size_class *class;
> +	void *addr;
> +
> +	WARN_ON(in_interrupt());

This macro is deprecated. Could you come up with something else like
!in_task() if needed?

> +	/* Guarantee we can get zspage from handle safely */
> +	read_lock(&pool->lock);
> +	obj =3D handle_to_obj(handle);
> +	obj_to_location(obj, &zpdesc, &obj_idx);
> +	zspage =3D get_zspage(zpdesc);
=E2=80=A6

Sebastian

