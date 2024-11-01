Return-Path: <linux-kernel+bounces-391727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 302D69B8AEF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 07:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A6628099A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 06:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345EA165F1F;
	Fri,  1 Nov 2024 06:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtOJuKqT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AAF1581F0;
	Fri,  1 Nov 2024 06:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730441050; cv=none; b=c7Y8UPPBLODhOUMWT5uzeqm1Dk8a5qYQso89TmT/2CTrLEHlM6UiMkSYlLbdsB4gX91hpiu9XGKzMWA61al2j54suOGSZmjGuR+3AsQu1IDrSTs6w2i/+fS7lRg4UONLC+YKImBMtiaACOZ68V/RHPZF+tCnB7rh0QJAl5esYf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730441050; c=relaxed/simple;
	bh=0oez5y69gm+AQB/CWPtX3mefE8bWVboNKSUC+suY4XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TnoGfVvvpdyDE5NU28LMwM4VEB76cOA+EcGORTWhgrUhfvqH9M97kaiwuULn27zDWkZ0LGPLX3ptmtSjWj+OHgKZg7EjNsiPS9Pr4S94k1VvW8DOV/L0UrOnKCfYWypz+FYzAp0lOkcl7MAvx38tZPXKrTVLYY653aDnbuUQCto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtOJuKqT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D27C4CED2;
	Fri,  1 Nov 2024 06:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730441048;
	bh=0oez5y69gm+AQB/CWPtX3mefE8bWVboNKSUC+suY4XA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NtOJuKqTlny8BqTGIXVBPv35LbXk1enKo9L332PUYTEEOb5VoCNkBJkfY4WzX4+uK
	 /8uchmnQ25LH6M85Ks3U5uRXEngWaLErpNiYibbJnXdwAVE5gxqK2jNrJSrRRZJvwx
	 8hwalbRAolLpuemQfj7IDxthbVq5I7B1xYwz4LzNitSWFDICapuBHNn2FOhkshTbhU
	 y+WNLfm+qLQc2xROuMcolsEWRh74tsNNlP/ingdDpp9yFx+kfE1cLgGCNB3FFfzC4p
	 Lf1qTLlnwGGvlojEJj5pNL+cTkBr0uR7WmAl8ahuUi6dDZ/wa6dCl+nsyMJZWDIi5r
	 /MNWFRB0nx+PQ==
From: William Breathitt Gray <wbg@kernel.org>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Philipp Stanner <pstanner@redhat.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: intel-qep: Replace deprecated PCI functions
Date: Fri,  1 Nov 2024 15:04:01 +0900
Message-ID: <173044101015.654738.17588227351532800458.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028091312.17045-2-pstanner@redhat.com>
References: <20241028091312.17045-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=505; i=wbg@kernel.org; h=from:subject:message-id; bh=tDc3RkITPOJOZtfpjBzexVaAcb7FSm74TVbLxwaU2b0=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDOkq+fbFH0yNQ5/8uXzU8fybNcdVdXJdPV6vD124zSlPY oZw3q/gjlIWBjEuBlkxRZZe87N3H1xS1fjxYv42mDmsTCBDGLg4BWAieisZGe791H3quMtKaZ/y pbfFh01ZHtzcwNYz4XIZpyNLxIMLc0wYGdp4zmc3KN3Yed5I+vCNbbxVWxRtLValdD649u5iwNr 5nFwA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Mon, 28 Oct 2024 10:13:13 +0100, Philipp Stanner wrote:
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated in
> commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
> pcim_iomap_regions_request_all()").
> 
> Replace these functions with pcim_iomap_region().
> 
> 
> [...]

Applied, thanks!

[1/1] counter: intel-qep: Replace deprecated PCI functions
      commit: 522ae89b78580c62765e160aed3479297baa75be

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>

