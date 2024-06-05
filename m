Return-Path: <linux-kernel+bounces-203071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8352F8FD5F2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A95CB2359C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AB022301;
	Wed,  5 Jun 2024 18:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tkd17MuU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36548139D10
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 18:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717613038; cv=none; b=hLdDKVWxB6R8Z5BZwm00m1X8pXFRdSWFxiXzPWM0zgFlEJg60bQ6K7aivZDy1wxNpkI0aLOc0BOI/Ew/AktUqsp5HCeHYKQmZZBTGuyR7DPJVYVAOtJ0sI0NRRXFVt4WmszO91zxaDKRz8GaW5eTsvu72V5Gw7cvrggHbXM8B0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717613038; c=relaxed/simple;
	bh=cmQPW06kzMzdKox9m8m1jh7GNWP+/LQm2wfZlpUN0zE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aXseOv201k5VTZWxhvVXZQwOO1s1g4+6mYHtBvI8Gk3WljZY6VdmluRua7inB9KGkT1Jzo69ceN1DsX+IUm5zs9FB5hk48M5i/7t0wdF+5lWUW6D0tPjd3onJ0r//ljSdG7l2bw0WvZcwvTaxZDF6AzsTbU17UFj99ghN8tFFlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tkd17MuU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72306C2BD11;
	Wed,  5 Jun 2024 18:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717613037;
	bh=cmQPW06kzMzdKox9m8m1jh7GNWP+/LQm2wfZlpUN0zE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tkd17MuUFZ+NzMexmWRrZCIilumk1ZP6GDRSJLyICuUDUPzFxa7CV3+asAFu70heb
	 5N2R8rVrAB+2Bt8MHphuorWMSfzUE3IQMfWW65l+CyVbdC9Q8vadChgV28E7pC0qNP
	 UXU+uuOvxYFh+2EYyGt7SZ7oRBEIf58MdN94HT3FJNGOuVtsEo0lppPV9iPU+sdqak
	 HLmTTtO+3aIsY++FO+mNHVaCQQBunkqIBSFEDfhKDNo0+SmfuCCs3WpoxQQ1TFB/PN
	 FR/zNC7SwsnAErI//AxywJXzI2++sHZ15dcKJZ1V+srs1rdGbSpYn4rnhZvYg7cger
	 +IA6w33LNR8/w==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org,
	Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Cyril Jean <cyril.jean@microchip.com>,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v1 0/5] PolarFire SoC Auto Update design info support
Date: Wed,  5 Jun 2024 19:42:54 +0100
Message-ID: <20240605-comply-cycling-d9bbc9a4c933@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410-opulently-epic-8654bdac3422@spud>
References: <20240410-opulently-epic-8654bdac3422@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1011; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=951blRr0Ng7FD/2XOVi7DbaObReZBWsO7Iyp9j4pFLA=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGkJG9dNvfRq/8If/zK3Hrx8NHGW9bzjzP2mp+TdJwfsf fTmyZlf3B2lLAxiHAyyYoosibf7WqTW/3HZ4dzzFmYOKxPIEAYuTgGYSEQPwz8rp3smAn/Xt4Tx +dezbulgWC4tn57X773rYarh6o8vQxYxMrytSTTkeXvNMYGnkf9J7rvE+pttZ113PIvxK9++siQ zmRsA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Wed, 10 Apr 2024 12:58:03 +0100, Conor Dooley wrote:
> There's a document that is internally available that the author of the
> design info/overlay format stuff wrote about how it is composed and I
> need to go read it and make a version of it publicly available before
> this can be merged.
> 
> While implementing the design info support, I found a few opportunities
> for cleaning up the code and fixed a bug that had been mentioned
> internally about failure cases printing success. The scope based cleanup
> stuff in particular is rather helpful for the drivers using the system
> services mailbox, so I'll roll that out to the other users soonTM.
> 
> [...]

The document that 1/5 relied on has been published, so I've applied
these to riscv-firmware-for-next.

[1/5] firmware: microchip: support writing bitstream info to flash
      https://git.kernel.org/conor/c/a2bf9dfe0090
[4/5] firmware: microchip: move buffer allocation into mpfs_auto_update_set_image_address()
      https://git.kernel.org/conor/c/e277026b5e2d

And 5/5 too, a conflict resolution seems to have upset b4.

Thanks,
Conor.

