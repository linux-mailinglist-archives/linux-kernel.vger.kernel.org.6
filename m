Return-Path: <linux-kernel+bounces-275281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C28ED9482B4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E2A02817C6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F9816BE13;
	Mon,  5 Aug 2024 19:55:48 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BE2143C69
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 19:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722887747; cv=none; b=Klb1E8KLAlFLQy2m4l5LTa3kK8dY0JR/BJSX+wxlExBf+sgyOQ/98b7R4SXirmBtmMsOUMleidW60S+tFx/hLhx+PMSwW4ny6GcGe5yF9M3gUYezcnI6fWxdsN7d8jSfJs+9HovwnP+XJfbZdP5ZUnCuLzvNK99DKh6ARM9pH70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722887747; c=relaxed/simple;
	bh=hBkeK+BsjSPgdX841yRg4dEEAOfYIsyFGAlKB+8QUSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnLRIB3mbUFziUOPOf69gXLZ5vIGB6qDq//30tRLYbbC+l7WbbyOxz3x1InQfhJKTygf7BCIKO1vHvbfXl6+WKUpbijYFoqV3HwPfTHFEbEjFsOvA4EGjsOi4D9FPZ8ZLT72oZ0spTz5GJlJHLC0AI6Jto4Nc0+PANMZQc8kz6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a1d984ed52so613797385a.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 12:55:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722887745; x=1723492545;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBkeK+BsjSPgdX841yRg4dEEAOfYIsyFGAlKB+8QUSE=;
        b=acJwnGXDNmX1+ggQi1ZoU//WLqZ6glqJGLaxnO84ZO0xEj0s9nf5Sl4uPXVDzcmYKm
         ZUuF7AZnXBX7IlUTSEyy4a9MID4hkCnb34L484FPXeDOHF6oF4aHujPXBx5qwrJ/0MI3
         5Z5qMGbCPTIsjo0VfOp9LZQHvv/L6HhferjeXk2la6POENjMmRDn3biKvfErxFMnGCa5
         djuG4rgpl3mzlEg9yN42P2u2W8HlcXlX0b/Z4+x9+WDaTkIXaVKZdzN6aUk/u8AbMLbG
         QtpWb8PljvrsFffGFsQReB08BDQcpvG1iL59+GrOd2y2ln6Oq75nt6e86YUZMIeL7ZHm
         iM3A==
X-Forwarded-Encrypted: i=1; AJvYcCXHN8hbjMzh+X1y+oLjvQ6yFntJeMbAC4if/Z3jQk0RoNfL/PsT3q/4dWOW7h7toj+GVDYypAOUbIlUsp/pDzaJ75En5OPRIbM/SwJ3
X-Gm-Message-State: AOJu0YxBW3RGPVIwD/JVCj8dfVSitcSHxHawf6ykIXDpPoZZTzxZRA1S
	9NFJzmFyA37PmHFBxbvb3zcxMxjDSPnNiMoQ+UxTb5Yfz4gFaMPp
X-Google-Smtp-Source: AGHT+IFlP8a2uoThjjlaJ3QIq0KzvT3+zkM16grMSAc8xwQYItFSmDV9tYnCILCzObyKdJ9AzPr1JQ==
X-Received: by 2002:a05:620a:4553:b0:79f:fe8:5fce with SMTP id af79cd13be357-7a34eebf3b3mr1362640285a.3.1722887744856;
        Mon, 05 Aug 2024 12:55:44 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6dca50sm380844785a.16.2024.08.05.12.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 12:55:44 -0700 (PDT)
Date: Mon, 5 Aug 2024 14:55:42 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, mingo@redhat.com
Subject: Re: [PATCH 6/6] sched_ext: Make task_can_run_on_remote_rq() use
 common task_allowed_on_cpu()
Message-ID: <20240805195542.GH42857@maniforge>
References: <20240804024047.100355-1-tj@kernel.org>
 <20240804024047.100355-7-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k8u/ER8A3WQ+nL2X"
Content-Disposition: inline
In-Reply-To: <20240804024047.100355-7-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--k8u/ER8A3WQ+nL2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 03, 2024 at 04:40:13PM -1000, Tejun Heo wrote:
> task_can_run_on_remote_rq() is similar to is_cpu_allowed() but there are
> subtle differences. It currently open codes all the tests. This is
> cumbersome to understand and error-prone in case the intersecting tests n=
eed
> to be updated.
>=20
> Factor out the common part - testing whether the task is allowed on the C=
PU
> at all regardless of the CPU state - into task_allowed_on_cpu() and make
> both is_cpu_allowed() and SCX's task_can_run_on_remote_rq() use it. As the
> code is now linked between the two and each contains only the extra tests
> that differ between them, it's less error-prone when the conditions need =
to
> be updated. Also, improve the comment to explain why they are different.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>

Acked-by: David Vernet <void@manifault.com>

--k8u/ER8A3WQ+nL2X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZrEuPQAKCRBZ5LhpZcTz
ZHNnAP98WJGXpmkgFLBrIpSdhKBtS0ltpruAdOKctj6wK21/ggD+NNIyQaqwsdfO
u/VgY71fNtNzes6u3h3AU710l4TPuwg=
=8rJE
-----END PGP SIGNATURE-----

--k8u/ER8A3WQ+nL2X--

