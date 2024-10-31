Return-Path: <linux-kernel+bounces-390899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CD69B7FCE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7781F21DE8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B990F1BBBCF;
	Thu, 31 Oct 2024 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9a02aup"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B2A1B6555
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391473; cv=none; b=RDjM18rruY8m6jJMdJHtCF/dZYqJnmNaMysPgRi1+8nPZttncy6JotmG0hOW+m9xDFXl4ObGUkUAVNvCeYb0ILhRpSATKinCkdms2Id/uO3GSW1nRDgNYMMU+bvYEvbvTGonnpH94NglQSOysP4r3avhluc44M/3j4G1YaD7rUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391473; c=relaxed/simple;
	bh=ABbJvTQuQQgU0omVbBZVhjJ4nsiZNq/XLYFVTH+WdcY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mgRSMnPIIyh1SfZnXz+NwWnkuqaU5MqQfagM9DDg5H2svhQLXvN+rI+hsjvSi8eLFgWrq/MWhO8Sw0QyTmtN6R4FEBmZ6KEIiK9AGPdsb0HXMzr6ZrbN6k6I1KnGQlIJ+3pnSe+CRpwk8Wp+YhEAPg6Wgc6eojyxz9/gidqKb/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9a02aup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F322C4DE18;
	Thu, 31 Oct 2024 16:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730391472;
	bh=ABbJvTQuQQgU0omVbBZVhjJ4nsiZNq/XLYFVTH+WdcY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=U9a02aupj/qDLBvB1/npl8IL5c7paZQDtHR+4XDe38nP8tMuTAhPGeUlNAjFDdOSf
	 xrrkVB+J0Qe/uvZ36HOSZJiQrm5hot/zlzrOqt8dXRW1lx8DOpxKS7uIrWMb1NaYLo
	 CsgKe3iXsd3jKLuho5h9Kn3lxLYjKwySMHBlWMlCYNFPnN6VNXP/skSx9Eo67DmV9d
	 IadN/e5CINL3oVlKiqTr6tIs/8MeJAVPErCpFwrROtnmIQWKi8Xvub1DXtLMX5Kuqy
	 0Pv3CBUlC6+/bUq4MR0uWHNJvf+wj0IJHMcx58+T5Dd6Dd9H8gE8elPbH3chVT9SYo
	 wEEwW9JB0i5xg==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Jean Delvare <jdelvare@suse.de>
Cc: linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20241022124745.5d8d3778@endymion.delvare>
References: <20241022124745.5d8d3778@endymion.delvare>
Subject: Re: (subset) [PATCH] mfd: adp5585: Drop obsolete dependency on
 COMPILE_TEST
Message-Id: <173039147132.1801602.7751944477402610893.b4-ty@kernel.org>
Date: Thu, 31 Oct 2024 16:17:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Tue, 22 Oct 2024 12:47:45 +0200, Jean Delvare wrote:
> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.
> 
> 

Applied, thanks!

[1/1] mfd: adp5585: Drop obsolete dependency on COMPILE_TEST
      commit: ac16ab764455824005e06fe0b37695a6eb72b282

--
Lee Jones [李琼斯]


