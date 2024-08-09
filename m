Return-Path: <linux-kernel+bounces-280955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9698794D159
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E1CFB23276
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C851196434;
	Fri,  9 Aug 2024 13:34:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D23194C75;
	Fri,  9 Aug 2024 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723210495; cv=none; b=gfIWQHu+vBQq+rCBbAl+LWK7hlZzuRmZHmzMVBriNEtLQWmc6PEhx1maQa0KgtUBrglmgJalKkcqJD/eGlbWAnWPV0BNuqNhmdILb+kz2ehfH3x8VzP9pb3/mWAfi8X8I7zFYAhbRdvRlmF8Fs3U45nunBPvIqyIw7mMcWQ8bYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723210495; c=relaxed/simple;
	bh=h68FbGqF2Jwvv6zHo7eWJ+ZWln0DuIKXZPCoBibFDcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=skhIfX75Om/OlfbN2MXhZ7FyHmm+lb5v0QNBYfl65oNdXfZG2sJm5h4Am/W8nXwz2Hsm9WtBqJv3pxEuj+LpNNSNGL7PgkIO55wc5fSLL5r/Ez2n2Av+saUYA/yvaMzzUkn/mvYlcctDvdMPd/LV9hIhpve15Yi9c07UEEi4Cls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A279F13D5;
	Fri,  9 Aug 2024 06:35:19 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 19F813F6A8;
	Fri,  9 Aug 2024 06:34:51 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: cristian.marussi@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RESEND] dt-bindings: firmware: arm,scmi: support system power protocol
Date: Fri,  9 Aug 2024 14:34:43 +0100
Message-ID: <172320989711.1571076.299636747129025085.b4-ty@arm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240628030309.1162012-1-peng.fan@oss.nxp.com>
References: <20240628030309.1162012-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 28 Jun 2024 11:03:09 +0800, Peng Fan (OSS) wrote:
> Add SCMI System Power Protocol bindings, and the protocol id is 0x12.
>

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/1] dt-bindings: firmware: arm,scmi: support system power protocol
      https://git.kernel.org/sudeep.holla/c/4d5921a39f67
--
Regards,
Sudeep


