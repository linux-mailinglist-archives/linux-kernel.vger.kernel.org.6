Return-Path: <linux-kernel+bounces-227444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A6F91514D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0E61C21EBA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9603419B3E1;
	Mon, 24 Jun 2024 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hX6lgAhz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E791E869;
	Mon, 24 Jun 2024 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241442; cv=none; b=FytCnlwd8ovbxxsBxAKcDS6AecpFfbJcZINDZjGiUOLLPPrVr8s80pWJEWAESdKkVjI5GwenOEqHrK4jEWPAPf4Br+owq2cDrkSxfAsKBCE4Ch6fZe7IhDxnQab7uxVLWDWfNMttUlb1wCvmvyCPPi9ZNL2M4wQUSOidjKJ/JLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241442; c=relaxed/simple;
	bh=pL5pT4yOWULjdyQiY7Dx0OcaqM/qghZcDutXrpJKO3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAvstGRrRsiQbNu2/CqL/FGoNo3yhLidcZ2BMxNUpH1UsF8TNeX6ldTP4KAdJLFd2o3vhBTRhZPQ22e9njLGRLxdKk3PPS9zyA6AfUGMm9oTU21WfbX+zxFYU7kWg/sDxhYBQ1sLYAVA0PeaP+6mtkgRiFqW5APoDeSzjzxQOyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hX6lgAhz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB4DC2BBFC;
	Mon, 24 Jun 2024 15:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719241441;
	bh=pL5pT4yOWULjdyQiY7Dx0OcaqM/qghZcDutXrpJKO3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hX6lgAhzRO27sRmolRzsH954/mdFR1FqaRnz0OGHONScSiz6EswsWDR233AyCkblQ
	 3btOnKfpxWy1NGBzg/E8H8xdGUxG2CG1VE/RsE0ZJROhK9T4+69S13jyVdtyBVo7vZ
	 TgEHH3MyaK4QKCIBpdrRKfR8yxeQg5A6wQK0mKhCewNvFopTDZA7vKmzhM1iTShJ6v
	 xtj8obOJ3EyChAhq/3GBpMpPguvsLqejgNRZgYzaCWUQKTl3x9bDz6dNuhS5biujuo
	 kOk9ClGk+0ejrbMIBmYQAqGeQSLv99zSdDKDzqSdQ/D2h6A4UdR9cKfR5yddMVx54o
	 jmBXVOv/5i0TA==
Date: Mon, 24 Jun 2024 09:04:00 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:FREESCALE SOC DRIVERS" <linuxppc-dev@lists.ozlabs.org>,
	"moderated list:FREESCALE SOC DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: soc: fsl: Convert q(b)man-* to yaml
 format
Message-ID: <20240624150400.GA3624893-robh@kernel.org>
References: <20240621213031.2759046-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621213031.2759046-1-Frank.Li@nxp.com>

On Fri, Jun 21, 2024 at 05:30:14PM -0400, Frank Li wrote:
> Convert qman, bman, qman-portals, bman-portals to yaml format.
> 
> Additional Chang for fsl,q(b)man-portal:

typo

> - Only keep one example.
> - Add fsl,qman-channel-id property.
> - Use interrupt type macro.
> - Remove top level qman-portals@ff4200000 at example.
> 
> Additional change for fsl,q(b)man:
> - Fixed example error.
> - Remove redundent part, only keep fsl,qman node.
> - Change memory-regions to memory-region.
> - fsl,q(b)man-portals is not required property
> 
> Additional change for fsl,qman-fqd.yaml:
> - Fixed example error.
> - Only keep one example.
> - Ref to reserve-memory.yaml
> - Merge fsl,bman reserver memory part
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/soc/fsl/bman-portals.txt         |  56 ------
>  .../devicetree/bindings/soc/fsl/bman.txt      | 137 -------------
>  .../bindings/soc/fsl/fsl,bman-portal.yaml     |  51 +++++
>  .../devicetree/bindings/soc/fsl/fsl,bman.yaml |  83 ++++++++
>  .../bindings/soc/fsl/fsl,qman-fqd.yaml        |  68 +++++++
>  .../bindings/soc/fsl/fsl,qman-portal.yaml     | 110 +++++++++++
>  .../devicetree/bindings/soc/fsl/fsl,qman.yaml |  97 +++++++++
>  .../bindings/soc/fsl/qman-portals.txt         | 134 -------------
>  .../devicetree/bindings/soc/fsl/qman.txt      | 187 ------------------
>  9 files changed, 409 insertions(+), 514 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soc/fsl/bman-portals.txt
>  delete mode 100644 Documentation/devicetree/bindings/soc/fsl/bman.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,bman-portal.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,bman.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,qman-fqd.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,qman-portal.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,qman.yaml
>  delete mode 100644 Documentation/devicetree/bindings/soc/fsl/qman-portals.txt
>  delete mode 100644 Documentation/devicetree/bindings/soc/fsl/qman.txt


> diff --git a/Documentation/devicetree/bindings/soc/fsl/fsl,bman-portal.yaml b/Documentation/devicetree/bindings/soc/fsl/fsl,bman-portal.yaml
> new file mode 100644
> index 0000000000000..06b51f049098f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/fsl/fsl,bman-portal.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/fsl/fsl,bman-portal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: QorIQ DPAA Queue Manager Portals
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +description:
> +  QorIQ DPAA Buffer Manager Portal
> +
> +  Portals are memory mapped interfaces to BMan that allow low-latency, lock-less
> +  interaction by software running on processor cores, accelerators and network
> +  interfaces with the BMan
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: fsl,bman-portal
> +      - items:
> +          - enum:
> +              - fsl,ls1043a-bmap-portal
> +              - fsl,ls1046a-bmap-portal
> +          - const: fsl,bman-portal
> +  reg:
> +    items:
> +      - description: the cache-enabled region of the portal
> +      - description: the cache-inhibited region of the porta

typo

> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    bman-portal@0 {
> +        compatible = "fsl,bman-portal-1.0.0", "fsl,bman-portal";
> +        reg = <0x0 0x4000>, <0x100000 0x1000>;
> +        interrupts = <105 IRQ_TYPE_EDGE_FALLING 0 0>;
> +    };
> diff --git a/Documentation/devicetree/bindings/soc/fsl/fsl,bman.yaml b/Documentation/devicetree/bindings/soc/fsl/fsl,bman.yaml
> new file mode 100644
> index 0000000000000..e6b3d489ce5cc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/fsl/fsl,bman.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/fsl/fsl,bman.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: QorIQ DPAA Buffer Manager
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +description:
> +  The Buffer Manager is part of the Data-Path Acceleration Architecture (DPAA).
> +  BMan supports hardware allocation and deallocation of buffers belonging to pools
> +  originally created by software with configurable depletion thresholds. This
> +  binding covers the CCSR space programming model
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: fsl,bman
> +      - items:
> +          - enum:
> +              - fsl,ls1043a-bman
> +              - fsl,ls1046a-bman
> +          - const: fsl,bman
> +
> +  reg:
> +    items:
> +      - description:

Needs '|' if you want formatting preserved.

> +          Registers region within the CCSR address space
> +
> +          The BMan revision information is located in the BMAN_IP_REV_1/2 registers which
> +          are located at offsets 0xbf8 and 0xbfc

Wrap lines at 80 unless there's a good reason to go to 100. There isn't 
here.

> +
> +  interrupts:
> +    items:
> +      - description: The error interrupt
> +
> +  memory-region:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array

memory-region already has a type. Need to define how many entries and 
what they are.

> +    description:
> +      List of phandles referencing the BMan private memory
> +      nodes (described below). The bman-fqd node must be
> +      first followed by bman-pfdr node. Only used on ARM
> +
> +      Devices connected to a BMan instance via Direct Connect Portals (DCP) must link
> +      to the respective BMan instance
> +
> +  fsl,bman-portals:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: ref fsl,bman-port.yaml
> +
> +  fsl,liodn:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      See pamu.txt, PAMU property used for static LIODN assignment
> +
> +  fsl,iommu-parent:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      See pamu.txt, PAMU property used for dynamic LIODN assignment
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - fsl,bman-portals
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    bman@31a000 {
> +        compatible = "fsl,bman";
> +        reg = <0x31a000 0x1000>;
> +        interrupts = <16 IRQ_TYPE_EDGE_FALLING 1 2>;
> +        fsl,liodn = <0x17>;
> +        fsl,bman-portals = <&bportals>;
> +        memory-region = <&bman_fbpr>;
> +    };
> diff --git a/Documentation/devicetree/bindings/soc/fsl/fsl,qman-fqd.yaml b/Documentation/devicetree/bindings/soc/fsl/fsl,qman-fqd.yaml
> new file mode 100644
> index 0000000000000..f7af14dc7deb6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/fsl/fsl,qman-fqd.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/fsl/fsl,qman-fqd.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: QMan Private Memory Nodes
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +description: |
> +  QMan requires two contiguous range of physical memory used for the backing store
> +  for QMan Frame Queue Descriptor (FQD) and Packed Frame Descriptor Record (PFDR).
> +  This memory is reserved/allocated as a node under the /reserved-memory node.
> +
> +  BMan requires a contiguous range of physical memory used for the backing store
> +  for BMan Free Buffer Proxy Records (FBPR). This memory is reserved/allocated as
> +  a node under the /reserved-memory node.
> +
> +  The QMan FQD memory node must be named "qman-fqd"
> +  The QMan PFDR memory node must be named "qman-pfdr"
> +  The BMan FBPR memory node must be named "bman-fbpr"
> +
> +  The following constraints are relevant to the FQD and PFDR private memory:
> +    - The size must be 2^(size + 1), with size = 11..29. That is 4 KiB to
> +      1 GiB
> +    - The alignment must be a muliptle of the memory size
> +
> +  The size of the FQD and PFDP must be chosen by observing the hardware features
> +  configured via the Reset Configuration Word (RCW) and that are relevant to a
> +  specific board (e.g. number of MAC(s) pinned-out, number of offline/host command
> +  FMan ports, etc.). The size configured in the DT must reflect the hardware
> +  capabilities and not the specific needs of an application
> +
> +  For additional details about reserved memory regions see reserved-memory.txt

Please read what that document says.

> +
> +properties:
> +  $nodename:
> +    pattern: '^(qman-fqd|qman-pfdr|bman-fbpr|)+$'

Don't need the last '|' or the '+'.

> +
> +  compatible:
> +    enum:
> +      - fsl,qman-fqd
> +      - fsl,qman-pfdr
> +      - fsl,bman-fbpr
> +
> +required:
> +  - compatible
> +
> +allOf:
> +  - $ref: reserved-memory.yaml
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    reserved-memory {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        qman-fqd {
> +            compatible = "shared-dma-pool";
> +            size = <0 0x400000>;
> +            alignment = <0 0x400000>;
> +            no-map;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/soc/fsl/fsl,qman-portal.yaml b/Documentation/devicetree/bindings/soc/fsl/fsl,qman-portal.yaml
> new file mode 100644
> index 0000000000000..6c81e0d66f4d5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/fsl/fsl,qman-portal.yaml
> @@ -0,0 +1,110 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/fsl/fsl,qman-portal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: QorIQ DPAA Queue Manager Portals
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +description:
> +  Portals are memory mapped interfaces to QMan that allow low-latency, lock-less
> +  interaction by software running on processor cores, accelerators and network
> +  interfaces with the QMan
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: fsl,qman-portal
> +      - items:
> +          - enum:
> +              - fsl,ls1043-qman-portal
> +              - fsl,ls1046-qman-portal
> +              - fsl,qman-portal-1.2.0
> +          - const: fsl,qman-portal
> +
> +  reg:
> +    items:
> +      - description: the cache-enabled region of the portal
> +      - description: the cache-inhibited region of the portal
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  fsl,liodn:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: See pamu.txt. Two LIODN(s). DQRR LIODN (DLIODN) and Frame LIODN
> +      (FLIODN)
> +
> +  fsl,iommu-parent:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: See pamu.txt.
> +
> +  fsl,qman-channel-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: qman channel id.
> +
> +  cell-index:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      The hardware index of the channel. This can also be
> +      determined by dividing any of the channel's 8 work queue
> +      IDs by 8
> +
> +      In addition to these properties the qman-portals should have sub-nodes to
> +      represent the HW devices/portals that are connected to the software portal
> +      described here
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +patternProperties:
> +  '^(fman0|fman1|pme|crypto|)+$':

Same regex problems here.

> +    type: object
> +    properties:
> +      fsl,liodn:
> +        description: See pamu.txt, PAMU property used for static LIODN assignment
> +
> +      fsl,iommu-parent:
> +        description: See pamu.txt, PAMU property used for dynamic LIODN assignment
> +
> +      dev-handle:
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +        description:
> +          The phandle to the particular hardware device that this
> +          portal is connected to.
> +
> +    additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    qman-portal@0 {
> +        compatible = "fsl,qman-portal-1.2.0", "fsl,qman-portal";
> +        reg = <0 0x4000>, <0x100000 0x1000>;
> +        interrupts = <104 IRQ_TYPE_EDGE_FALLING 0 0>;
> +        fsl,liodn = <1 2>;
> +        fsl,qman-channel-id = <0>;
> +
> +        fman0 {
> +            fsl,liodn = <0x21>;
> +            dev-handle = <&fman0>;
> +        };
> +
> +        fman1 {
> +            fsl,liodn = <0xa1>;
> +            dev-handle = <&fman1>;
> +        };
> +
> +        crypto {
> +            fsl,liodn = <0x41 0x66>;
> +            dev-handle = <&crypto>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/soc/fsl/fsl,qman.yaml b/Documentation/devicetree/bindings/soc/fsl/fsl,qman.yaml
> new file mode 100644
> index 0000000000000..341c3d2cfd6c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/fsl/fsl,qman.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/fsl/fsl,qman.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: QorIQ DPAA Queue Manager
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +description:
> +  The Queue Manager is part of the Data-Path Acceleration Architecture (DPAA). QMan
> +  supports queuing and QoS scheduling of frames to CPUs, network interfaces and
> +  DPAA logic modules, maintains packet ordering within flows. Besides providing
> +  flow-level queuing, is also responsible for congestion management functions such
> +  as RED/WRED, congestion notifications and tail discards. This binding covers the
> +  CCSR space programming model
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: fsl,qman
> +      - items:
> +          - enum:
> +              - fsl,ls1043a-qman
> +              - fsl,ls1046a-qman
> +          - const: fsl,qman
> +  reg:
> +    items:
> +      - description:
> +          Registers region within the CCSR address space
> +
> +          The QMan revision information is located in the QMAN_IP_REV_1/2 registers which
> +          are located at offsets 0xbf8 and 0xbfc
> +
> +  interrupts:
> +    items:
> +      - description: The error interrupt
> +
> +  fsl,qman-portals:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: ref fsl,qman-port.yaml
> +
> +  fsl,liodn:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      See pamu.txt, PAMU property used for static LIODN assignment
> +
> +  fsl,iommu-parent:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      See pamu.txt, PAMU property used for dynamic LIODN assignment
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      See clock-bindings.txt and qoriq-clock.txt

Drop.

> +      Reference input clock. Its frequency is half of the platform clock
> +
> +  memory-region:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      List of phandles referencing the QMan private memory
> +      nodes (described below). The qman-fqd node must be
> +      first followed by qman-pfdr node. Only used on ARM
> +
> +      Devices connected to a QMan instance via Direct Connect Portals (DCP) must link
> +      to the respective QMan instance
> +
> +  fsl,qman:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      List of phandle and DCP index pairs, to the QMan instance
> +      to which this device is connected via the DCP
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - fsl,qman-portals
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    qman: qman@318000 {
> +        compatible = "fsl,qman";
> +        reg = <0x318000 0x1000>;
> +        interrupts = <16 IRQ_TYPE_EDGE_FALLING 1 3>;
> +        fsl,liodn = <0x16>;
> +        fsl,qman-portals = <&qportals>;
> +        memory-region = <&qman_fqd &qman_pfdr>;
> +        clocks = <&platform_pll 1>;
> +    };

