Return-Path: <linux-kernel+bounces-377880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C41F9AC801
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33BC41F2481C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07C61A0B08;
	Wed, 23 Oct 2024 10:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEzpmZy1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432E71662F6;
	Wed, 23 Oct 2024 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729679419; cv=none; b=RXFBui1dJXG5wJNhYdyx/2cNY8IYn26r72tTkPr2IZ8E+MjaFjOHYaaMD+vxPO+VVTXpSS/pkSHzz71rGlRazMLPBoh5uwVIzJag+6cpDhsPcaNN2lSZ5wJKjZ5mvVHSlzxWUqJ+rhF/RHRtv+XQwx+MsBBvs+JE0BUwLsQ7jE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729679419; c=relaxed/simple;
	bh=1yMvsbqKKxCmPBDkUMt3vUIL8R4RjnBl2vB8/PDwUCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+fXSVTfADxfYHL/eE7KsUeEQrbbf9XbP9Y4ud7R+w6HBoxmLIH9RuPePty6S7n8Eyh6vzqfqvuUpeGQJAyImZBJHOrjWXW4n1kqXFNDEkHIt4Gl3CDXb65tNUrNqol3rEE6jX7eZeVVtq6E7qOS7MCTPIuCSugLZPXnKdE1miM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEzpmZy1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33056C4CEC6;
	Wed, 23 Oct 2024 10:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729679416;
	bh=1yMvsbqKKxCmPBDkUMt3vUIL8R4RjnBl2vB8/PDwUCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pEzpmZy1WbauAFljLYu5X2oUuavpPzogfbG3dvJHq0uRYEpUy5HPRo4Vyr3ZZVT59
	 Dpmgxb0X8TpTPJcxQqbmpChIdwace8Zxaqe9T/5BocCVCz6EbbRFgyTpQ6eNb7sQPV
	 UJhZoOOW/eNy0BB31qEtbSJ/kzdyUMNhHwF3Iqb24Xu0gdyc4Sx0TjWQH7yFtNYanC
	 Km8POoGWxxaFPqQM342sVLn5reVMpoowxkv2VJK/vSQa6jyvCYmVJZ+gvXXA4WoeWG
	 TfpbrlahDd5K1bxKh8K9fSYwMO8H9z+9tEzBBINPqs75DhUHUpvneD/2H4GGur096c
	 7tMHv33au6qxQ==
From: Conor Dooley <conor@kernel.org>
To: Henry Bell <dmoo_dv@protonmail.com>,
	E Shattow <e@freeshell.de>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: starfive: Update ethernet phy0 delay parameter values for Star64
Date: Wed, 23 Oct 2024 11:30:03 +0100
Message-ID: <20241023-guts-versus-1a2bcfdfbec2@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241022061004.62812-1-e@freeshell.de>
References: <20241022061004.62812-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=965; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=+Ekbc+eRHl5mRs0Lm29hCW/ghDBTMs/HMot0ehs2yl0=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOkSF7QL0ree2ZbMXZQlMCXr76OrQdvPHms5pi8w05kn1 rn2Y9iyjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAExkRw8jwzHbSR0bzPOnlKkv OVUq98LQgVHDZdnJL+fNwyYnhosaZDD8M3rfJsfbvHmzt57gc/bPn0I4xWaW3Diw78tsza7aDKl SPgA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Mon, 21 Oct 2024 23:09:51 -0700, E Shattow wrote:
> Improve function of Star64 bottom network port phy0 with updated delay values.
> Initial upstream patches supporting Star64 use the same vendor board support
> package parameters known to result in an unreliable bottom network port.
> 
> Success acquiring DHCP lease and no dropped packets to ping LAN address:
> rx  900: tx 1500 1650 1800 1950
> rx  750: tx      1650 1800 1950
> rx  600: tx           1800 1950
> rx 1050: tx      1650 1800 1950
> rx 1200: tx 1500 1650 1800 1950
> rx 1350: tx 1500 1650 1800 1950
> rx 1500: tx 1500 1650 1800 1950
> rx 1650: tx 1500 1650 1800 1950
> rx 1800: tx 1500 1650 1800 1950
> rx 1900: tx                1950
> rx 1950: tx                1950
> 
> [...]

Applied to riscv-soc-fixes, thanks!

[1/1] riscv: dts: starfive: Update ethernet phy0 delay parameter values for Star64
      https://git.kernel.org/conor/c/825bb69228c8

Thanks,
Conor.

