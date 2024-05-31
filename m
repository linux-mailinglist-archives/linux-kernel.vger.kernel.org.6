Return-Path: <linux-kernel+bounces-196686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F638D5FED
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FB241C220FF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D18E15625D;
	Fri, 31 May 2024 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="in97geYf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DD615099E
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 10:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717152455; cv=none; b=gEwtfgeW9xWTf/j00/H/lG49jJ1HeOd5qR8vfTQgMMlgAUfBYTOw0a6uRwSLPFgHFQyizmbKBkk1VwTE7npjdQsKiAeV7UGOOJf5buPaYjBCEddN9BMlcdvdtjhb4b0jyAJE70tTdkfDOCLyxycLrc6VtIuMiFavckTyQ14Z9QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717152455; c=relaxed/simple;
	bh=Tdt4uSgyecbJEaMus/2Zplv+zl/MWijQgsFVMHTBidg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rbv1O0hBp//M981pOLoJJWXfTkjbiLs7OMAD/t+4r/tIQ7bM2DFNg5qRgB3wMulq0jag0eI0nDoQNfQ7bp14iCC4lTNXOitJDErkmijZNbVAv7i1v8qpYp5Y4K2FbgDBDBNa3GubfygIN208+s/c1TConvc5PTEo0CAFmG9idd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=in97geYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86626C116B1;
	Fri, 31 May 2024 10:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717152455;
	bh=Tdt4uSgyecbJEaMus/2Zplv+zl/MWijQgsFVMHTBidg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=in97geYf8bhcN67gZSviJTE1fOE3aiw5kGEu4WJTPF8I1M4r07Ap+oZ1xIN4+Nkls
	 mOmSDLcqnUsTssObff3iC/6xoplQmS519PhV4oHzb5VlZaBqS0XCfBE8aKR/w2Udom
	 /ZpKkAk3oGXuClqCKNl+Fbx6D4NQ6xCsuTEqkRnYvGXBiI8WEkG+snDQtmJmt5LLgM
	 Xn6IlS3g6Y9Lpsr39Q777tmfyOWvyIDM2Cd5kRAtJsxa4DWRUF6KI4H0CoKUtRiN7I
	 hJr1bjTo0c91QbaFeWMh96zEy9iwsbDxVt7OvQQUmrJyD5J74zoDNjC7G7rK9Vqtdd
	 2tzbab6GUS9tg==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20240507-clockmatrix-kernel-doc-v2-1-3138d74192dd@kernel.org>
References: <20240507-clockmatrix-kernel-doc-v2-1-3138d74192dd@kernel.org>
Subject: Re: (subset) [PATCH v2] mfd: idt8a340_reg: Start comments with
 '/*'
Message-Id: <171715245427.1032054.11571308221023085863.b4-ty@kernel.org>
Date: Fri, 31 May 2024 11:47:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Tue, 07 May 2024 17:53:56 +0100, Simon Horman wrote:
> Several comments in idt8a340_reg.h start with '/**', which denotes the
> start of a Kernel doc, but are otherwise not Kernel docs.
> 
> Resolve this conflict by starting these comments with '/*' instead.
> 
> Flagged by ./scripts/kernel-doc -none
> 
> [...]

Applied, thanks!

[1/1] mfd: idt8a340_reg: Start comments with '/*'
      commit: 1b9e05aaeeef7021b14a332c7132094a73180c34

--
Lee Jones [李琼斯]


