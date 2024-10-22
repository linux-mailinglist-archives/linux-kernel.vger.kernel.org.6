Return-Path: <linux-kernel+bounces-376880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB41C9AB703
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 013621C21227
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478391CB510;
	Tue, 22 Oct 2024 19:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHnpYUc6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F3D1C9ED4
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625825; cv=none; b=sxPVY1lTUZk8eY1qQkYBiyEPbfrVvuJ9vJr23VKPmiwN4DY8pxisOEUhrZ9XMSdyPBuBj5R7XoA1KpqNJB2taVKjVEDQQz0Pas/2MH6zS9cD7PBZ4vrinvwEGae6fHb7xOmTPOqnW6eqL9LPEnCiMgoNAQ7qsoB0Tm5qlQEAkvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625825; c=relaxed/simple;
	bh=sZA6OaNE85IYms12hN/AHrBX1hB0kVFvlXO8HaFfGCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R62Wgncy2A3UM9qKzvWJisLrkT51sBXyW9gkZ3vAZNioVxiEo7NWNGxFqLKytZD8PE7nnvTol+lEVdJ7kQ+oJrBSJBKhODMSKM7gLw9Mityd23GyFVjd2AgQ0o9blMg9rkw7JtNRX7Y6V8wXsPSo1hYm+pLNrDE61I1BNQS2u50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHnpYUc6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41387C4CEC3;
	Tue, 22 Oct 2024 19:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729625825;
	bh=sZA6OaNE85IYms12hN/AHrBX1hB0kVFvlXO8HaFfGCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rHnpYUc6tyyd+tihRg1E4+MHZ6w5sAnmF8h+guIsNC+IN+UmfrwukocvwNbYva27w
	 WulOAqxo9p/9yUrFygjrp/o7G2v4M3QxVctrCqPinETOhEn4WQ2Wd7cM+XwEEBJL/g
	 Jvqtxn6jTDh6z7drpL/mAB/r5yrbgjAZcb8glTV8EAdMxh0WB+vtzvDcQCC8QgiYNF
	 srtWsk00FOe8NJuUBXTu1/397dGrzbv+qRyzmJ6IqfEjPXvruvjAoIglBguYvx5ifP
	 WqvWjoPLNCBdw1VDpn/inQGksMAs2A+cmsUtNUn40x/iGizWjYg79cbw3ANGaWr+t7
	 XhHT/8rcajgpA==
From: Kees Cook <kees@kernel.org>
To: Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] seccomp: Stub for !HAVE_ARCH_SECCOMP_FILTER
Date: Tue, 22 Oct 2024 12:37:00 -0700
Message-Id: <172962581580.4006205.14311870462068442574.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022-seccomp-compile-error-v2-1-c9f08a4f8ebb@linaro.org>
References: <20241022-seccomp-compile-error-v2-1-c9f08a4f8ebb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 22 Oct 2024 15:41:34 +0200, Linus Walleij wrote:
> If we have CONFIG_SECCOMP but not CONFIG_HAVE_ARCH_SECCOMP_FILTER
> we get a compilation error:
> 
> ../kernel/entry/common.c: In function 'syscall_trace_enter':
> ../kernel/entry/common.c:55:23: error: implicit declaration of function '__secure_computing' [-Werror=implicit-function-declaration]
>    55 |                 ret = __secure_computing(NULL);
>       |                       ^~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to for-next/seccomp, thanks!

[1/1] seccomp: Stub for !HAVE_ARCH_SECCOMP_FILTER
      https://git.kernel.org/kees/c/8cf8dfceebda

Take care,

-- 
Kees Cook


