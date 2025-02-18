Return-Path: <linux-kernel+bounces-519612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9DAA39EB7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B62164323
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026D326A08C;
	Tue, 18 Feb 2025 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmfgsKvj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6294512E5B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739888609; cv=none; b=PBxrRcWMPJVFIxvxpcpEE72YVBzbg6FeuUl5O/2h4O0Ky4UCE6H4gkF+LqV/jD1+GzZa3ybNUVAbDb9m6xgpI8sDBHOfd6KdA+p1U0zEnX1ak0PTnJYCPk4nkclf2XlVRVxi8tK3BQRojOd1ldxyHGDjWH3w0oK3WM3C3s8WjPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739888609; c=relaxed/simple;
	bh=6H2IVdf+klJfMtaEaYNKN81zCweCPS/MEZvVQuL1bKc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eXaLzRi+SzQK8/dAWxngkxJpSNftLYt0Bkms90m7PSKFqLp1g7Utt+2ITlie+KzLhb/dibQ3+9TIfvNiYDU+t3IUOpUIabtQGaB0/cLfnxQRQiBuIXhgTr50LhZ38m0UoxYtbGehwagc6Ax6zlKMhAFExowT/3odq92NOOnKkH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmfgsKvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EF7C4CEE2;
	Tue, 18 Feb 2025 14:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739888608;
	bh=6H2IVdf+klJfMtaEaYNKN81zCweCPS/MEZvVQuL1bKc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hmfgsKvjHkzqBOqZPXoCe6Nhsb/eMx1p6OFfUEZuw0Eu/exVhlPYU2EH6S5AJSNRv
	 ZRJ3G1SOIPZoA1tKAxazGIpH5ouQQ62zGMkwiRmjMVH6E86XPIcKlphiDmaz76KDuK
	 9Ptt0KuEddqD59dXVrmYK5oCWqKCNCTOApYuTxjqT29gtPoMApfh534k2Tc3yOj1oJ
	 rd8smYOhmMH9i27USaVeplihsfC/DtDC4cGy9HCAZ7cHcmYfvS5Q+DUybJUZfFADp2
	 I9XZZWkRLO+pLxWOlEIpJYa1jYNjktkysTN3uotH7uKpDs+L8uSg4UVt55OWU6Bo/l
	 5hyxixXgGqT8Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <mwalle@kernel.org>,  Miquel Raynal <miquel.raynal@bootlin.com>,  Richard
 Weinberger <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mtd: spi-nor: sort headers alphabetically
In-Reply-To: <20250211-spi-nor-guard-mutex-v1-1-05ed77a484d9@linaro.org>
	(Tudor Ambarus's message of "Tue, 11 Feb 2025 09:30:53 +0000")
References: <20250211-spi-nor-guard-mutex-v1-0-05ed77a484d9@linaro.org>
	<20250211-spi-nor-guard-mutex-v1-1-05ed77a484d9@linaro.org>
Date: Tue, 18 Feb 2025 14:23:26 +0000
Message-ID: <mafs0pljfl4bl.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 11 2025, Tudor Ambarus wrote:

> Sorting headers alphabetically helps locating duplicates,
> and makes it easier to figure out where to insert new headers.

Series applied to spi-nor/next. Thanks!

-- 
Regards,
Pratyush Yadav

