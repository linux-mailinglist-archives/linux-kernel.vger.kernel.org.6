Return-Path: <linux-kernel+bounces-577634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82E9A71FBB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96C267A5508
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788A523E226;
	Wed, 26 Mar 2025 19:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doJ1Wddb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E7A1F30DE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 19:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743018922; cv=none; b=RjYUJ61TDgBeYdSr3taV8EQ/j28o60zDg7Y+Airj6aADoiEU01j4dOdunyR1Zt23dP/uvuaAWkEoCRy4ogYex3An5v/f10mv6Y2BWuSwadVqNpWh0i9K4NTywvl6W7i6o4T+lU6o1hK7tq1iGm6QX3MaGDhE4AUAikz7whas9YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743018922; c=relaxed/simple;
	bh=nFrsPsXGyg7m+ZZ6UQ4BRIYIgHOwnQskzRMAesy+Du0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JDzyb5tuXpzB3S3xk6GL/vzV8RVZZ6ShrpwAVqdrSXXAThA9IfZCaErn+PVS69iB2Zf6yFHrOjWXmeWr0iOUzS2+v25Axf97A6Dx5BLujYazeAx/m7QMHhrlg42zmFy8quvC3hWLVqvNYAWqHQIco+ePdi8NQXvzGD5Fsyyuqzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doJ1Wddb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4E3C4CEE2;
	Wed, 26 Mar 2025 19:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743018922;
	bh=nFrsPsXGyg7m+ZZ6UQ4BRIYIgHOwnQskzRMAesy+Du0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=doJ1WddbUcYChQOFokGgl3KdzGDlzBfhe6fkJbReCCmt6xhxinm/FoT9DQGNAhaYZ
	 7UcEjps/yH0faors5yXpHFdxXIU/ZANQ9ZLEq+qgLrCtJD0YMWWZlXMKvsDnHLBKZq
	 /eCAhQhWle9NPpVUYlWiiV5Km3Qr2vGLnZSQkWWnwk9zZDFFjymgfJeGYH11akq20e
	 XWf/3DeU2vNMMR8RZpMeBnK34VSwTnx9zgNzBhajnKmiVaiU+Lw+xEgKpLLSL/iF+E
	 vEQfLv5S1RiXxYT3Rd+IqKeNuMHEgTT5cZoW3apsv+R7vTdTxnB2d9HS/tMeX92//M
	 x0dM56g/0E5PA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Yao Zi <ziyao@disroot.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Andrew Jones <ajones@ventanamicro.com>,
 Ying Sun <sunying@isrc.iscas.ac.cn>, Arnd Bergmann <arnd@arndb.de>, Yao Zi
 <ziyao@disroot.org>, Kent Overstreet <kent.overstreet@linux.dev>, Li
 Zhengyu <lizhengyu3@huawei.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv/kexec_file: Fix comment in purgatory relocator
In-Reply-To: <20250326073450.57648-2-ziyao@disroot.org>
References: <20250326073450.57648-2-ziyao@disroot.org>
Date: Wed, 26 Mar 2025 20:55:19 +0100
Message-ID: <87tt7fk1nc.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yao Zi <ziyao@disroot.org> writes:

> Apparently sec_base doesn't mean relocated symbol value, which seems a
> copy-pasting error in the comment. Assigned with the address of section
> indexed by sym->st_shndx, it should represent base address of the
> relevant section. Let's fix the comment to avoid possible confusion.
>
> Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")
> Signed-off-by: Yao Zi <ziyao@disroot.org>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

